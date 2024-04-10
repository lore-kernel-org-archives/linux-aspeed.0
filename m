From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Thu, 11 Apr 2024 09:25:54 +0930
Subject: [PATCH v2 1/4] dt-bindings: rtc: convert trivial devices into
 dtschema
In-Reply-To: <20240410-rtc_dtschema-v2-1-d32a11ab0745@gmail.com>
References: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
	 <20240410-rtc_dtschema-v2-1-d32a11ab0745@gmail.com>
Message-ID: <6de98551118955bf68f4835b888730222a9ae015.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2024-04-10 at 17:55 +0200, Javier Carrasco wrote:
> These RTCs meet the requirements for a direct conversion into
> trivial-rtc:
> 
> - orion-rtc
> - google,goldfish-rtc
> - maxim,ds1742
> - rtc-aspped

Nit: s/aspped/aspeed/, but otherwise it still looks fine for the Aspeed
bits and you can keep my R-b tag.

Andrew
