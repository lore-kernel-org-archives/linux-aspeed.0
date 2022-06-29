From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 29 Jun 2022 19:21:08 +0200
Subject: [PATCH v3 2/2] spi: aspeed: Fix division by zero
In-Reply-To: <YryHVsrqNlhdwKzq@sirena.org.uk>
References: <20220622161617.3719096-1-clg@kaod.org>
 <20220622161617.3719096-3-clg@kaod.org> <YryHVsrqNlhdwKzq@sirena.org.uk>
Message-ID: <59b82730-f09f-f7e5-0e2f-4ad1765f0f6e@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 6/29/22 19:09, Mark Brown wrote:
> On Wed, Jun 22, 2022 at 06:16:17PM +0200, C?dric Le Goater wrote:
> 
>> Fixes: 54613fc6659b ("spi: aspeed: Add support for direct mapping")
> 
> This commit isn't in mainline.

drat. It's the OpenBMC kernel. I will resend. Sorry about that.

C.
