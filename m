From: Rob Herring <robh@kernel.org>
Date: Tue, 04 Sep 2018 08:36:33 -0500
Subject: [PATCH 1/4] clock: aspeed: Add VIDEO reset index definition
In-Reply-To: <1535576973-8067-2-git-send-email-eajames@linux.vnet.ibm.com>
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1535576973-8067-2-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <5b8e8a62.1c69fb81.6801.2c0d@mx.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 29 Aug 2018 16:09:30 -0500, Eddie James wrote:
> Add an index into the array of resets kept in the Aspeed clock driver.
> This isn't a HW bit definition.
> 
> Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
> ---
>  include/dt-bindings/clock/aspeed-clock.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

