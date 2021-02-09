From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 10 Feb 2021 10:04:20 +1030
Subject: [PATCH v3 1/2] drm/aspeed: Look up syscon by phandle
In-Reply-To: <20210209123734.130483-2-joel@jms.id.au>
References: <20210209123734.130483-1-joel@jms.id.au>
 <20210209123734.130483-2-joel@jms.id.au>
Message-ID: <cfafac8d-5162-4024-8f23-372fac7851dd@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Tue, 9 Feb 2021, at 23:07, Joel Stanley wrote:
> This scales better to multiple families of SoC. The lookup by compatible
> can be removed in a future change.
> 
> The fallback path is for the ast2500 platform only. Other platforms will
> be added with the new style, so they won't need fallback paths.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
