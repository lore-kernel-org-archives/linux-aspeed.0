From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 8 Dec 2021 13:21:42 +0100
Subject: [PATCH v3 0/4] Refactor Aspeed USB vhub driver
In-Reply-To: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
Message-ID: <YbCjVqAie/d84oBm@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 08, 2021 at 06:05:41PM +0800, Neal Liu wrote:
> These patch series include 2 parts. One is adding more features
> to pass USB30CV compliance test, the other is fixing hw issues.
> More detail descriptions are included below patchsets.
> 
> Change since v2:
> - Add more description in changelog.
> - Fix remote wakeup issue patch and make it more configurable.
> 
> Change since v1:
> - Remove unnecessary configs for SET_CONFIGURATION.
> - Separate supporting test mode to new patch.
> 
> *** BLURB HERE ***

Blurb is missing :(
