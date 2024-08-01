From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 01 Aug 2024 11:13:50 +0930
Subject: [PATCH] iio: adc: aspeed: Use of_property_present()
In-Reply-To: <20240731191312.1710417-5-robh@kernel.org>
References: <20240731191312.1710417-5-robh@kernel.org>
Message-ID: <3770677daec27d5cfa9c952ba03a77875bc24b56.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-07-31 at 13:12 -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
