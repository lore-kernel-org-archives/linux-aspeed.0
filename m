From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Sep 2019 11:12:15 +0100
Subject: [PATCH v3 4/5] gpios: Use ngpio property from device tree if
 available
In-Reply-To: <20190906062727.13521-1-rashmica.g@gmail.com>
References: <20190906062727.13521-1-rashmica.g@gmail.com>
Message-ID: <CACRpkdYbyHtC_gQqvc5cwYGqUPt1cYTW0cQVxPDah4XrdYB8Kw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 6, 2019 at 7:27 AM Rashmica Gupta <rashmica.g@gmail.com> wrote:

> Use the ngpio property from the device tree if it exists. If it doesn't
> then fallback to the hardcoded value in the config.
>
> This is in preparation for adding ast2600 support. The ast2600 SoC has
> two GPIO controllers and so requires two instances of the GPIO driver.
> We use the ngpio property to different between them as they have
> different numbers of GPIOs.
>
> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>

Patch applied with some fuzzing.

Yours,
Linus Walleij
