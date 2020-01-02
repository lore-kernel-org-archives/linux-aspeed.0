From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 2 Jan 2020 18:56:19 +0000
Subject: [net-next PATCH] net/ncsi: Fix gma flag setting after response
In-Reply-To: <20191230.203442.69341487993928315.davem@davemloft.net>
References: <20191227224349.2182366-1-vijaykhemka@fb.com>
 <20191230.203442.69341487993928315.davem@davemloft.net>
Message-ID: <6494F283-FC28-459D-B9DE-494FC8D0CAFA@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 12/30/19, 8:34 PM, "David Miller" <davem@davemloft.net> wrote:

    From: Vijay Khemka <vijaykhemka@fb.com>
    Date: Fri, 27 Dec 2019 14:43:49 -0800
    
    > gma_flag was set at the time of GMA command request but it should
    > only be set after getting successful response. Movinng this flag
    > setting in GMA response handler.
    > 
    > This flag is used mainly for not repeating GMA command once
    > received MAC address.
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Applied.
Thanks David
    

