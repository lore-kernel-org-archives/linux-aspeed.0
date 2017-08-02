From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Aug 2017 10:36:58 +0200
Subject: [PATCH v2 2/4] dt-bindings: pinctrl: aspeed: Add g5 USB functions
In-Reply-To: <20170718052453.14316-3-andrew@aj.id.au>
References: <20170718052453.14316-1-andrew@aj.id.au>
 <20170718052453.14316-3-andrew@aj.id.au>
Message-ID: <CACRpkdYEqM36pGpRSiAVeV92TgQUP4nYgadPNm-Sf-so9+t+rw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 18, 2017 at 7:24 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> The Aspeed AST2500 SoC contains a number of USB controllers:
>
> * USB 1.1 Host Controller
> * USB 2.0 Host Controller (x2)
> * USB 2.0 Virtual Hub
> * USB 2.0 Device Controller
> * USB 1.1 HID Controller
>
> The controllers are exposed via two USB ports with functionality muxed
> as required. The following table illustrates the relationships between
> the ports and the controllers via the mux function names:
>
> Port  | USB Version  | USB Mode     | Mux Function
> ------|--------------|--------------|-------------
> A     | 2.0          | Virtual Hub  | USB2AD
> A     | 2.0          | Host         | USB2AH
> B     | 1.1          | HID          | USB11BHID
> B     | 2.0          | Device       | USB2BD
> B     | 2.0          | Host         | USB2BH
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v1 -> v2:

Patch applied.

Yours,
Linus Walleij
