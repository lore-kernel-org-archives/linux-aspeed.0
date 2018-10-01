From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 1 Oct 2018 22:45:06 +0000
Subject: [Potential Spoof] Re: [PATCH v2] net/ncsi: Add NCSI OEM command
 support
Message-ID: <4B3FCCBC-0A9B-47D0-876D-323D12DFD09B@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 9/28/18, 6:21 PM, "Linux-aspeed on behalf of Vijay Khemka" <linux-aspeed-bounces+vijaykhemka=fb.com at lists.ozlabs.org on behalf of vijaykhemka@fb.com> wrote:

    
    
    > On 9/28/18, 6:07 PM, "Vijay Khemka" <vijaykhemka@fb.com> wrote:
    
     >   This patch adds OEM commands and response handling. It also defines OEM
     >   command and response structure as per NCSI specification along with its
     >   handlers.
     >   
     >   ncsi_cmd_handler_oem: This is a generic command request handler for OEM
     >   commands
     >   ncsi_rsp_handler_oem: This is a generic response handler for OEM commands
       
      This is a generic patch for OEM command handling, There will be another patch 
      following this to handle specific OEM commands for each vendor. Currently I have
      defined 2 vendor/manufacturer id below in internal.h, more can be added here for
      other vendors. I have not defined ncsi_rsp_oem_handler in this patch as they are 
      NULL, but there will be a defined handlers for each vendor in next patch. 
     
Sam, Joel, Justin, please review this patch. I have 2 more patch coming for Broadcom and Mellanox. 

