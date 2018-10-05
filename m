From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 5 Oct 2018 17:32:58 +0000
Subject: [PATCH v3] net/ncsi: Add NCSI OEM command support
In-Reply-To: <88dc95b120e89acbfaa0e8442822c1b3f5696a57.camel@mendozajonas.com>
References: <20181003233222.3909359-1-vijaykhemka@fb.com>
 <88dc95b120e89acbfaa0e8442822c1b3f5696a57.camel@mendozajonas.com>
Message-ID: <B1C3BBF2-C64F-40DB-9D61-DECF7AAF2B53@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 10/4/18, 9:48 PM, "Samuel Mendoza-Jonas" <sam@mendozajonas.com> wrote:

    On Wed, 2018-10-03 at 16:32 -0700, Vijay Khemka wrote:
    > This patch adds OEM commands and response handling. It also defines OEM
    > command and response structure as per NCSI specification along with its
    > handlers.
    > 
    > ncsi_cmd_handler_oem: This is a generic command request handler for OEM
    > commands
    > ncsi_rsp_handler_oem: This is a generic response handler for OEM commands
    > 
    > Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
    
    Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
    
    Technically this patch should also be marked [PATCH net-next] to target
    David's next tree.
  
  Thanks Sam, I will mark it and send it again to larger audience.
    
  

