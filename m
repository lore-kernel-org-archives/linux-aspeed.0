From: Neal Liu <neal_liu@aspeedtech.com>
Date: Wed, 11 Oct 2023 03:26:42 +0000
Subject: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
In-Reply-To: <20231006213917.333702-1-robh@kernel.org>
References: <20231006213917.333702-1-robh@kernel.org>
Message-ID: <TYZPR06MB6770154F3A65CE1E6AF7283080CCA@TYZPR06MB6770.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Use preferred device_get_match_data() instead of of_match_device() to get
> the driver match data. With this, adjust the includes to explicitly include the
> correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
