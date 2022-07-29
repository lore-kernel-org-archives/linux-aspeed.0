From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 29 Jul 2022 12:07:39 +0930
Subject: [PATCH linux dev-5.15] soc: aspeed: abr: Add sysfs attrs for flash toggle
In-Reply-To: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
References: <20220501105644.355062-1-zhangjian.3032@bytedance.com>
Message-ID: <62143648-8a90-4ff4-bfe1-f311b40cd50c@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jian Zhang,

On Sun, 1 May 2022, at 20:26, Jian Zhang wrote:
> Implement the flash toggle function in soc ast2600.
> Add two sysfs attrs named "access_primary" and "access_backup"

If you're proposing this patch for upstream then it needs to be based on
an upstream kernel tree, not the OpenBMC kernel tree. You also should
not use e.g. `linux dev-5.15` in the patch subject prefix, as that would
be inappropriate for an upstream patch.

As you're adding sysfs attributes you'll also need to add the
corresponding ABI documentation.

Cheers,

Andrew
