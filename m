From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 12 Sep 2020 12:07:59 +0200
Subject: [PATCH v2 01/15] dt-bindings: gpio: convert bindings for NXP
 PCA953x family to dtschema
In-Reply-To: <c162b6ad-57f1-a75a-11e3-9c80c60bd845@ti.com>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-2-krzk@kernel.org>
 <CACPK8XdocAX5mOXf3VP29cNXH+6unYunB9NiT3qFVKyzR6WXPg@mail.gmail.com>
 <CAJKOXPe6Tf0B5W27XaD5zLk77OBzGCHpirhTdZjFH0oh8GvWgg@mail.gmail.com>
 <c162b6ad-57f1-a75a-11e3-9c80c60bd845@ti.com>
Message-ID: <CACRpkdbrrzkYVW13V89PJ5_WRGhxSL0rOxAHA_7hYSyw28Shvg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 11:54 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> More over, there is already generic schema for gpio hogs: gpio-hog.yaml

Where is this? I don't have it in my GPIO devel branch for sure, and
it is not in linux-next either so not in Bartosz' tree.

I did suggest that I want a gpio-common.yaml file which includes the
hogs.

> Originally, gpio bindings were defined without restricting gpio hog node names and,
> generic schema follows this.
>
> I think, the generic "gpio-hogs" sub-node may be introduced to place gpio hogs child nodes,
> if gpio hogs node names restriction need to be introduces (*which i'm not sure is reasonable*).
>
> gpio at 20 {
>         gpio-hogs {
>                 yyy-hog {
>                          gpio-hog;
>                          gpios
>                 }
>         }
>
> But this require as gpio code as generic gpio schema update (with backward compatibility in mind).

The whole problem I have with the DT bindings is that defining
them is not really a Linux problem and the people maintaining it even want
to move it out of the Linux kernel tree. It is supposedly the responsibility of
all operating systems using device tree including but not limited to BSD
and Zephyr.

But there is noone picking up the responsibility outside of the Linux kernel
tree except for Rob and Rob cannot do everything.

With things like this it breaks apart because noone takes the overall
responsibility. And as subsystem maintainer I am fully overloaded with
the Linux side of things.

This is of course not your or anyone else's fault. But:
GPIO DT binding maintainers/writers wanted!

Yours,
Linus Walleij
