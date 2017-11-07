From: Joel Stanley <joel@jms.id.au>
Date: Tue, 7 Nov 2017 15:31:39 +1030
Subject: [PATCH v3 2/2] gpio: aspeed: Add support for reset tolerance
In-Reply-To: <20171101040457.1200-3-andrew@aj.id.au>
References: <20171101040457.1200-1-andrew@aj.id.au>
 <20171101040457.1200-3-andrew@aj.id.au>
Message-ID: <CACPK8XcTU84w4e4qtbUxsqBNpv2ucNu4AcicHWb7NRrVM3Dveg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 1, 2017 at 2:34 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> Use the new pinconf parameter for state persistence to expose the
> associated capability of the Aspeed GPIO controller.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

I took a look and checked the offsets against the datasheet. LGTM.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
