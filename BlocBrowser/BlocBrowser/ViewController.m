//
//  ViewController.m
//  BlocBrowser
//
//  Created by Michael Henkelman on 5/11/15.
//  Copyright (c) 2015 Michael Henkelman. All rights reserved.
//

#import "ViewController.h"
#import "BLCAwesomeFloatingToolbar.h"

#define kBLCWebBrowserBackString NSLocalizedString(@"Back", @"Back Command")
#define kBLCWebBrowserForwardString NSLocalizedString(@"Forward", @"Forward Command")
#define kBLCWebBrowserStopString NSLocalizedString(@"Stop", @"Stop Command")
#define kBLCWebBrowserRefreshString NSLocalizedString(@"Refresh", @"Reload Command")


@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, BLCAwesomeFloatingToolbarDelegate>

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) BLCAwesomeFloatingToolbar *awesomeToolbar;
@property (nonatomic, assign) NSUInteger frameCount;


@end

@implementation ViewController

#pragma mark = UIViewController

- (void)loadView {
    UIView *mainView = [UIView new];
    
    self.webview = [[UIWebView alloc] init];
    self.webview.delegate = self;
    
    self.textField = [[UITextField alloc] init];
    self.textField.keyboardType = UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Website URL or Search", @"Placeholder text for web browser URL and search field");
    self.textField.backgroundColor = [UIColor colorWithWhite:220/255.0f alpha:1];
    self.textField.delegate = self;
    
    self.awesomeToolbar = [[BLCAwesomeFloatingToolbar alloc]initWithFourTitles:@[kBLCWebBrowserBackString, kBLCWebBrowserForwardString, kBLCWebBrowserStopString, kBLCWebBrowserRefreshString]];
    self.awesomeToolbar.delegate = self;
    
    
    for (UIView *viewToAdd in @[self.webview, self.textField, self.awesomeToolbar ]) {
        [mainView addSubview: viewToAdd];
    }
    
    
    self.view = mainView;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Welcome", @"Welcome title") message:NSLocalizedString(@"Welcome to the Internet", @"Greeting") delegate:nil cancelButtonTitle:NSLocalizedString(@"Proceed online", @"Proceed") otherButtonTitles:nil];
    [alert show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    self.awesomeToolbar.frame = CGRectMake(20, 100, 280, 60);

}


- (void)viewWillLayoutSubviews {
 
    [super viewWillLayoutSubviews];
    
    static const CGFloat itemHeight = 50;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat browserHeight = CGRectGetHeight(self.view.bounds) - itemHeight;
    
    self.textField.frame = CGRectMake(0, 0, width, itemHeight);
    self.webview.frame = CGRectMake(0, CGRectGetMaxY(self.textField.frame), width, browserHeight);
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    NSString *URLString = textField.text;
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSString *searchScan = URLString;
    NSRange scanRange = [searchScan rangeOfString:@" "];
    
    if (!URL.scheme) {
        
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", URLString]];
    }
    
    if (scanRange.location != NSNotFound) {
        NSString *searchURL = [searchScan stringByReplacingOccurrencesOfString:@" " withString:@"+"];

        URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://google.com/search?q=%@", searchURL]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webview loadRequest:request];
    
    
        return NO;
}

#pragma mark - UIWebViewDelegate

- (void)UIWebViewDidStartLoad:(UIWebView *)webView {
    self.frameCount++;
    [self updateButtonsAndTitle];
}
                 
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.frameCount--;
    [self updateButtonsAndTitle];
                     
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code != -999) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    
    [alert show];
        
    }
    
    [self updateButtonsAndTitle];
    self.frameCount--;
    
}

#pragma mark - BLCAwesomeFloatingToolbarDelegate

- (void) floatingToolbar:(BLCAwesomeFloatingToolbar *)toolbar didSelectButtonWithTitle:(NSString *)title {
    
    if ([title isEqual:kBLCWebBrowserBackString]) {
        [self.webview goBack];
    } else if ([title isEqual:kBLCWebBrowserForwardString]) {
        [self.webview goForward];
    } else if ([title isEqual:kBLCWebBrowserStopString]) {
        [self.webview stopLoading];
    } else if ([title isEqual:kBLCWebBrowserRefreshString]) {
        [self.webview reload];
    }
}

#pragma mark - Miscellaneous

- (void) updateButtonsAndTitle {
    NSString *webpageTitle = [self.webview stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if (webpageTitle) {
        self.title = webpageTitle;
    } else {
        self.title = self.webview.request.URL.absoluteString;
    }
    
    if (self.frameCount > 0) {
        [self.activityIndicator startAnimating];
    } else {
        [self.activityIndicator stopAnimating];
    }
    
    [self.awesomeToolbar setEnabled:[self.webview canGoBack] forButtonWithTitle:kBLCWebBrowserBackString];
    [self.awesomeToolbar setEnabled:[self.webview canGoForward] forButtonWithTitle:kBLCWebBrowserForwardString];
    [self.awesomeToolbar setEnabled:self.frameCount > 0 forButtonWithTitle:kBLCWebBrowserStopString];
    [self.awesomeToolbar setEnabled:self.webview.request.URL && self.frameCount == 0 forButtonWithTitle:kBLCWebBrowserRefreshString];
    
}

- (void) resetWebView {
    [self.webview removeFromSuperview];
    
    UIWebView *newWebView = [[UIWebView alloc] init];
    newWebView.delegate = self;
    [self.view addSubview:newWebView];
    
    self.webview = newWebView;
    
    
    self.textField.text = nil;
    [self updateButtonsAndTitle];
    
}

- (void) floatingToolbar:(BLCAwesomeFloatingToolbar *)toolbar didTrytToPanWithOffset:(CGPoint)offset {
    CGPoint startingPoint = toolbar.frame.origin;
    CGPoint newPoint = CGPointMake(startingPoint.x +offset.x, startingPoint.y + offset.y);
    
    CGRect potentialNewFrame = CGRectMake(newPoint.x, newPoint.y, CGRectGetWidth(toolbar.frame), CGRectGetHeight(toolbar.frame));
    
    if (CGRectContainsRect(self.view.bounds, potentialNewFrame)) {
        toolbar.frame = potentialNewFrame;
    }
}

- (void) floatingToolbar:(BLCAwesomeFloatingToolbar *)toolbar didPinchWithScale:(CGFloat)scale {
    CGPoint toolbarCurrentPoint = toolbar.frame.origin;
    CGFloat newX = toolbarCurrentPoint.x - (toolbar.frame.size.width*scale-toolbar.frame.size.width)/2;
    CGFloat newY = toolbarCurrentPoint.y - (toolbar.frame.size.height*scale-toolbar.frame.size.height)/2;
    
    CGRect potentialNewFrame = CGRectMake(newX, newY, toolbar.frame.size.width*scale, toolbar.frame.size.height*scale);
    
    if (CGRectContainsRect(self.view.bounds, potentialNewFrame)) {
        toolbar.frame = potentialNewFrame;
    }
    
}




@end
