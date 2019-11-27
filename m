From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 28 Nov 2019 09:05:21 +1030
Subject: [PATCH v4] ARM: dts: aspeed: Adding Facebook Yosemite V2 BMC
In-Reply-To: <20191127132340.GA22672@cnn>
References: <20191127132340.GA22672@cnn>
Message-ID: <ba027dc2-613c-40c6-bb5e-1d320e51b191@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 27 Nov 2019, at 23:53, manikandan-e wrote:
> The Yosemite V2 is a facebook multi-node server
> platform that host four OCP server. The BMC
> in the Yosemite V2 platorm based on AST2500 SoC.
> 
> This patch adds linux device tree entry related to
> Yosemite V2 specific devices connected to BMC SoC.
> 
> Signed-off-by: manikandan-e <manikandan.hcl.ers.epl@gmail.com>

If people have reviewed previous versions of your patches and sent
Reviewed-by/Acked-by/Tested-by tags, please make sure to include
them on future versions of the patches _unless_ there has been
significant change that might invalidate the tag. In that case, also
provide a short description as to why you dropped the tags. You can
add free-form information below the `---` and it will not be included
in the commit for the patch.

Cheers,

Andrew
