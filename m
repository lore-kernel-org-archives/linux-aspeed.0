From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 09 Apr 2024 21:23:00 +0930
Subject: [PATCH 5/9] dt-bindings: rtc: rtc-aspeed: move to trivial-rtc
In-Reply-To: <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
	 <20240408-rtc_dtschema-v1-5-c447542fc362@gmail.com>
Message-ID: <4adaae76f71c0f1f84ae10de68ce9837f1057463.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-04-08 at 17:53 +0200, Javier Carrasco wrote:
> The RTCs documented in this binding require a compatible, a reg
> and a single interrupt, which make them suitable for a direct
> conversion into trivial-rtc.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks,

Andrew
