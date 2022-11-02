From: Rob Herring <robh@kernel.org>
Date: Wed, 2 Nov 2022 11:07:09 -0500
Subject: [PATCH 2/2] dt-bindings: iio: adc: Remove the property
 "aspeed,trim-data-valid"
In-Reply-To: <20221031113208.19194-2-billy_tsai@aspeedtech.com>
References: <20221031113208.19194-1-billy_tsai@aspeedtech.com>
 <20221031113208.19194-2-billy_tsai@aspeedtech.com>
Message-ID: <166740522806.3978983.397017282901820216.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Mon, 31 Oct 2022 19:32:08 +0800, Billy Tsai wrote:
> The valid of the trimming data will use the otp default value as a
> criterion.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  .../devicetree/bindings/iio/adc/aspeed,ast2600-adc.yaml    | 7 -------
>  1 file changed, 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
