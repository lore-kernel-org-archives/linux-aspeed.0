From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 7 Jan 2020 09:20:25 -0800
Subject: [PATCH 1/3] media: aspeed: Rework memory mapping in probe
In-Reply-To: <20200107034324.38073-2-joel@jms.id.au>
References: <20200107034324.38073-1-joel@jms.id.au>
 <20200107034324.38073-2-joel@jms.id.au>
Message-ID: <1f4b4c28-83e6-9fdb-f7a2-67e786a656c3@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/6/2020 7:43 PM, Joel Stanley wrote:
> Use the recently introduced function devm_platform_ioremap_resource to
> save a few lines of code. This makes the driver match common platform
> device probe patterns.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Thanks,

Jae
