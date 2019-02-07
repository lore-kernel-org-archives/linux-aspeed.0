From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 7 Feb 2019 07:47:57 +0000
Subject: [PATCH v3] dt-bindings: aspeed-lpc: Make parameter optional
In-Reply-To: <20190129230538.1044378-1-vijaykhemka@fb.com>
References: <20190129230538.1044378-1-vijaykhemka@fb.com>
Message-ID: <20190207074757.GA4672@dell>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 29 Jan 2019, Vijay Khemka wrote:

> Memory-region and flash phandle is not a required parameter, it is
> optional to describe in device tree and needed only use basis.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> ---
>  Documentation/devicetree/bindings/mfd/aspeed-lpc.txt | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
