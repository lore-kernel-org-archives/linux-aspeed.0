From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 08 Nov 2021 10:59:17 +1030
Subject: [PATCH v2] soc: aspeed: lpc-ctrl: Block error printing on probe
 defer cases
In-Reply-To: <20211104173709.222912-1-jae.hyun.yoo@intel.com>
References: <20211104173709.222912-1-jae.hyun.yoo@intel.com>
Message-ID: <f2b3f804-0908-489e-8a95-65f35f4c3e61@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 5 Nov 2021, at 04:07, jae.hyun.yoo at intel.com wrote:
> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>
> Add a checking code when it gets -EPROBE_DEFER while getting a clock
> resource. In this case, it doesn't need to print out an error message
> because the probing will be re-visited.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
