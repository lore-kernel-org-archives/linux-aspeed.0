From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 20 Nov 2019 16:39:25 +1030
Subject: [PATCH v3 1/3] aspeed: dts: add sd card for vesnin
In-Reply-To: <20191118104646.3838-2-i.mikhaylov@yadro.com>
References: <20191118104646.3838-1-i.mikhaylov@yadro.com>
 <20191118104646.3838-2-i.mikhaylov@yadro.com>
Message-ID: <ebe4c175-a1a0-47d3-9c01-1dfeeffc97e5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 18 Nov 2019, at 21:16, Ivan Mikhaylov wrote:
> Presence signal is inverted for vesnin boards, 'cd-inverted' added
> for invertion signal enablement. Vesnin BMC uses microSD, there is
> no WP switch, 'disable-wp' is used for this purpose.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
