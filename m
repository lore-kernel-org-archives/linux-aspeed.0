From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 25 Mar 2024 12:59:02 +1030
Subject: [PATCH 05/64] i2c: aspeed: reword according to newest
 specification
In-Reply-To: <20240322132619.6389-6-wsa+renesas@sang-engineering.com>
References: <20240322132619.6389-1-wsa+renesas@sang-engineering.com>
	 <20240322132619.6389-6-wsa+renesas@sang-engineering.com>
Message-ID: <93bd01d104f752d29d182249773e83c230a3ab20.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-03-22 at 14:24 +0100, Wolfram Sang wrote:
> Match the wording of this driver wrt. the newest I2C v7, SMBus 3.2, I3C
> specifications and replace "master/slave" with more appropriate terms.
> They are also more specific because we distinguish now between a remote
> entity ("client") and a local one ("target").
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
