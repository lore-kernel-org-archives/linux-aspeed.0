From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 10 Oct 2023 09:50:42 +1030
Subject: [PATCH] crypto: aspeed-hace: Use device_get_match_data()
In-Reply-To: <20231006213917.333702-1-robh@kernel.org>
References: <20231006213917.333702-1-robh@kernel.org>
Message-ID: <e303d57d5bac0bb8227e09ef6eea5867cf7866d9.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2023-10-06 at 16:39 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
