From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 16 Dec 2018 01:23:46 +0100
Subject: [PATCH] pinctrl: aspeed: Wrap -Woverride-init with cc-option
In-Reply-To: <20181211000506.7559-1-natechancellor@gmail.com>
References: <20181211000506.7559-1-natechancellor@gmail.com>
Message-ID: <CACRpkdYH9VDjzpH90X=gTKAnw1guGG3uUjDmUXcSkBxg=6LgyA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Dec 11, 2018 at 1:05 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Clang does not support this option:
>
> warning: unknown warning option '-Woverride-init'; did you mean
> '-Woverride-module'? [-Wunknown-warning-option]
> 1 warning generated.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Patch applied with the ACKs!

Yours,
Linus Walleij
