From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 21 Mar 2018 10:52:38 +0800
Subject: [PATCH 2/5] serial: expose buf_overrun count through proc interface
In-Reply-To: <20180321025241.19785-1-jk@ozlabs.org>
References: <20180321025241.19785-1-jk@ozlabs.org>
Message-ID: <20180321025241.19785-3-jk@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The buf_overrun count is only every written, and not exposed to
userspace anywhere. This means that dropped characters due to flip
buffer overruns are never visible to userspace.

The /proc/tty/driver/serial file exports a bunch of metrics (including
hardware overruns) already, so add the buf_overrun (as "bo:") to this
file.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 8f3dfc8b5307..fc677534b510 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1780,6 +1780,8 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
 			seq_printf(m, " brk:%d", uport->icount.brk);
 		if (uport->icount.overrun)
 			seq_printf(m, " oe:%d", uport->icount.overrun);
+		if (uport->icount.buf_overrun)
+			seq_printf(m, " bo:%d", uport->icount.buf_overrun);
 
 #define INFOBIT(bit, str) \
 	if (uport->mctrl & (bit)) \
-- 
2.14.1

