From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Mar 2022 01:17:58 +0000
Subject: [PATCH 0/5] Fix AST2600 quad mode SPI pinmux settings
In-Reply-To: <CACRpkdbFNLLve1-JntNW=eMT9ivZTZHBk-xpwK6w-kE0fczr+g@mail.gmail.com>
References: <20220308003745.3930607-1-quic_jaehyoo@quicinc.com>
 <CACRpkdbFNLLve1-JntNW=eMT9ivZTZHBk-xpwK6w-kE0fczr+g@mail.gmail.com>
Message-ID: <CACPK8Xejcvv37uhGUXOTrbXJ=0O17tiDNizo9jtbRqHxyFiLhg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 17 Mar 2022 at 01:11, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Mar 8, 2022 at 1:37 AM Jae Hyun Yoo <quic_jaehyoo@quicinc.com> wrote:
>
> > I?m sending this patch series to fix current issues in AST2600 pinmux
> > settings while enabling quad mode SPI support.
>
> Patches 2 & 3 applied to the pinctrl tree.
>
> Please funnel the DTS patches through the SoC tree.

Thanks for jumping on this Linus. We're not sure that this is the
correct fix, Andrew is still reviewing (see the comments on patch 3):

 https://lore.kernel.org/linux-arm-kernel/CACRpkdbFNLLve1-JntNW=eMT9ivZTZHBk-xpwK6w-kE0fczr+g at mail.gmail.com/T/#m2cdf4f8b55427d6040f5c13eb85dd656f3579c48

If you haven't pushed it out then please hold off. If you have, I'll
let Andrew jump in and recommend the best course of action.

>
> Yours,
> Linus Walleij
