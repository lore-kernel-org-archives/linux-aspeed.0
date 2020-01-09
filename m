From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 09 Jan 2020 12:23:32 +1030
Subject: [PATCH] fsi: aspeed: convert to devm_platform_ioremap_resource
In-Reply-To: <20191228190631.26777-1-tiny.windzz@gmail.com>
References: <20191228190631.26777-1-tiny.windzz@gmail.com>
Message-ID: <f93bd92d-e509-4825-a4bf-00f5b7c6ff7d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sun, 29 Dec 2019, at 05:36, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
