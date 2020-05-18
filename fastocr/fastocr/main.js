require('UIButton,UIColor');
defineClass('ViewController', {
    viewDidLoad: function() {
        self.super().viewDidLoad();

        self.loadButton();
    },
    loadButton: function() {
        var tipBtn = UIButton.alloc().initWithFrame(CGRectMake(100, 150, 200, 60));
        tipBtn.setBackgroundColor(UIColor.greenColor());
        tipBtn.setTitleColor_forState(UIColor.redColor(), UIControlStateNormal);
        tipBtn.setTitleColor_forState(UIColor.blueColor(), UIControlStateHighlighted);
        tipBtn.setTitle_forState("hello_jspatch", UIControlStateNormal);
        tipBtn.addTarget_action_forControlEvents(self, @selector(clickedBtn: ), UIControlEventTouchUpInside);
        self.view().addSubview(tipBtn);
    },
    clickedBtn: function(sender) {
        sender.setBackgroundColor(UIColor.yellowColor());
    },
});
