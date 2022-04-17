From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Apr 2022 01:28:18 +0200
Subject: [PATCH v3 0/7] Fix AST2600 quad mode SPI pinmux settings
In-Reply-To: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
Message-ID: <CACRpkdZff-TbnNHO6Q590ubyH51+yqN68DOghazVKvYoHMBekw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jae,

On Tue, Mar 29, 2022 at 7:40 PM Jae Hyun Yoo <quic_jaehyoo@quicinc.com> wrote:

> Jae Hyun Yoo (5):
>   pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl
>   dt-bindings: pinctrl: aspeed-g6: remove FWQSPID group
>   dt-bindings: pinctrl: aspeed-g6: add FWQSPI function/group
>   pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group

These four patches applied to the pinctrl tree.

Please funnel patches 1, 6, 7 through the SoC tree.

Yours,
Linus Walleij
