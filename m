From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Jun 2024 14:27:55 -0500
Subject: [PATCH 1/3] dt-bindings: pinctrl: aspeed: Use block syntax for
 function and groups
In-Reply-To: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-1-a6fe2281a1b8@codeconstruct.com.au>
References: <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-0-a6fe2281a1b8@codeconstruct.com.au>
 <20240531-dt-warnings-gpio-ast2600-pinctrl-funcs-groups-v1-1-a6fe2281a1b8@codeconstruct.com.au>
Message-ID: <20240604192755.GA1065421-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 31, 2024 at 12:32:47PM +0930, Andrew Jeffery wrote:
> The expansion makes the documents a lot longer, but it's easier to
> review changes to functions and groups when we're not having to deal
> with line wrapping.

Do you really expect to be updating this frequently? I would leave it 
as-is, but whatever you decide.

> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---

Acked-by: Rob Herring (Arm) <robh@kernel.org>
