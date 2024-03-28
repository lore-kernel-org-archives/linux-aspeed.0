From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:15:05 +0100
Subject: [PATCH v2] pinctrl: pinctrl-aspeed-g6: Fix register offset for
 pinconf of GPIOR-T
In-Reply-To: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
References: <20240313092809.2596644-1-billy_tsai@aspeedtech.com>
Message-ID: <CACRpkdaxekb_E4ttW5XfRUa+srkjOzUaVXRAtHMYjkVir7R7xQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 13, 2024 at 10:28?AM Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The register offset to disable the internal pull-down of GPIOR~T is 0x630
> instead of 0x620, as specified in the Ast2600 datasheet v15
> The datasheet can download from the official Aspeed website.
>
> Fixes: 15711ba6ff19 ("pinctrl: aspeed-g6: Add AST2600 pinconf support")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied.
I recorded Delphine's similar patch as "reported-by".

Yours,
Linus Walleij
