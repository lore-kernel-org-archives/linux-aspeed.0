From: David Miller <davem@davemloft.net>
Date: Fri, 05 Oct 2018 14:54:58 -0700 (PDT)
Subject: [PATCH net-next] net/ncsi: Add NCSI OEM command support
In-Reply-To: <20181005174602.828803-1-vijaykhemka@fb.com>
References: <20181005174602.828803-1-vijaykhemka@fb.com>
Message-ID: <20181005.145458.746711951646640462.davem@davemloft.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 5 Oct 2018 10:46:01 -0700

> This patch adds OEM commands and response handling. It also defines OEM
> command and response structure as per NCSI specification along with its
> handlers.
> 
> ncsi_cmd_handler_oem: This is a generic command request handler for OEM
> commands
> ncsi_rsp_handler_oem: This is a generic response handler for OEM commands
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> Reviewed-by: Justin Lee <justin.lee1@dell.com>
> Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied.
