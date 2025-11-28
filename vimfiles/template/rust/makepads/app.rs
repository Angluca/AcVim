//#![allow(unused)]
//use std::path::{Path, PathBuf};
use makepad_widgets::*;

live_design! {
    use link::theme::*;
    use link::shaders::*;
    use link::widgets::*;

    App = {{App}} {
        ui: <Root> {
            main_window = <Window> {
                width: Fill,
                height: Fill,
                show_bg: true,
                draw_bg: {
                    fn pixel(self) -> vec4{
                        return #267;
                    }
                }
                // 定义窗口主体
                body = <ScrollXYView>{
                    // 布局方向为垂直
                    flow: Down,
                    // 子项间距为10
                    spacing:10,
                    // 对齐方式
                    align: {
                        x: 0.5,
                        y: 0.5
                    },
                    // 按钮组件
                    button1 = <Button> {
                        text: "Hello world"
                        draw_text:{ color: #f00 } // 文字颜色为红色
                    }

                    // 文本输入组件
                    label1 = <Label> {
                        draw_text: {
                            color: #f // 文字颜色为白色
                        },
                        text: "Label: Click to count "
                    }

                    // 文本输入组件
                    input1 = <TextInput> {
                        width: Fit, height: Fit
                        text: "Counter: 0 "
                    }
                }
            }
        }
    }
}

#[derive(Live, LiveHook)]
pub struct App {
    #[live] ui: WidgetRef,
    #[rust] counter: usize,
}

impl LiveRegister for App {
    fn live_register(cx: &mut Cx) {
        makepad_widgets::live_design(cx);
    }
}

// 实现 MatchEvent 特性，用于处理事件
impl MatchEvent for App {
    fn handle_actions(&mut self, cx: &mut Cx, actions: &Actions) {
        // 检查按钮是否被点击
        // 这里可以直接通过 `ids!()`使用 button1 实例，获取被点击 Button
        // `clicked` 是 Button 组件的方法
        if self.ui.button(ids!(button1)).clicked(&actions) {
            // 增加计数器
            log!("BUTTON jk {}", self.counter);
            self.counter += 1;
            // 更新标签文本
            // 同样，通过 `ids!()` 获取 input1 文本输入实例
            let input = self.ui.text_input(ids!(input1));
            // 通过文本输入框组件内置的 `set_text`
            // 更新文本输入框的内容为新的计数器值。
            input.set_text(cx, &format!("Counter: {}", self.counter));

            let label = self.ui.label(ids!(label1));
            label.set_text(cx, &format!("Label: Click to count {}", self.counter));
        }
    }
}

// 实现 AppMain 特性，用于处理事件
impl AppMain for App {
    fn handle_event(&mut self, cx: &mut Cx, event: &Event) {
        // 匹配事件并处理
        self.match_event(cx, event);
        // 处理 UI 事件，本例就是 `<Root>`
        // 这里调用的是实现 Widget trait 时定义的 handle_event 方法
        self.ui.handle_event(cx, event, &mut Scope::empty());
    }
}

app_main!(App);
