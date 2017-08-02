From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:38:55 +0200
Subject: [PATCH v2 4/4] pinctrl: aspeed: g5: Add USB device and host
 support
In-Reply-To: <20170718052453.14316-5-andrew@aj.id.au>
References: <20170718052453.14316-1-andrew@aj.id.au>
 <20170718052453.14316-5-andrew@aj.id.au>
Message-ID: <CACRpkda1ER+4PEC_9zZhzA2o3Eb32eyec6mNYVW8c_8A+oX0mQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 18, 2017 at 7:24 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> Implement the AST2500 USB functions as described by the devicetree
> bindings. The AST2500 exposes five USB controllers through two USB
> ports. Similar to the AST2400, the pins exposing USB are outliers with
> respect to the rest of the pinmux as they not capable of GPIO.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied.

Yours,
Linus Walleij
