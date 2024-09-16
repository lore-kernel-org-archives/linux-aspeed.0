From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Sep 2024 11:21:22 +0930
Subject: [PATCH v3 2/6] gpio: aspeed: Remove the name for bank array
In-Reply-To: <20240913074325.239390-3-billy_tsai@aspeedtech.com>
References: <20240913074325.239390-1-billy_tsai@aspeedtech.com>
	 <20240913074325.239390-3-billy_tsai@aspeedtech.com>
Message-ID: <2dc5f4bea2fbafa4f69df6d9ba167b8b62794e57.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-09-13 at 15:43 +0800, Billy Tsai wrote:
> The bank array name is only used to determine if the GPIO offset is valid,
> and this condition can be replaced by checking if the offset exceeds the
> ngpio property.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

