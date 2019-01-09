From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 9 Jan 2019 18:42:31 +0000
Subject: phosphor-ipmi-host.service broken
Message-ID: <F7A6D855-479B-48FD-98C0-FEAAB372B52A@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I see new changes in this phosphor-ipmi-host.service file where it needs org.openbmc.HostIpmi.service service to be running and this org.openbmc.HostIpmi.service service depends on phosphor-ipmi-host.service file. So it is cyclic dependency which in turn not letting run any of these service.



Regards

-Vijay
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190109/36a4d397/attachment.html>
