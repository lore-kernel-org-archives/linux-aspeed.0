From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 14 Jan 2019 08:41:40 +1030
Subject: phosphor-ipmi-host.service broken
In-Reply-To: <F7A6D855-479B-48FD-98C0-FEAAB372B52A@fb.com>
References: <F7A6D855-479B-48FD-98C0-FEAAB372B52A@fb.com>
Message-ID: <1547417500.2307798.1633547288.3FA0702E@webmail.messagingengine.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Vijay,

The linux-aspeed at lists.ozlabs.org list is for kernel patches going upstream - Joel uses it as a way to track relevant patches in patchwork. For openbmc discussions (i.e. userspace questions like this) please use openbmc at lists.ozlabs.org


On Thu, 10 Jan 2019, at 05:12, Vijay Khemka wrote:
> I see new changes in this phosphor-ipmi-host.service file where it needs 
> org.openbmc.HostIpmi.service service to be running and this 
> org.openbmc.HostIpmi.service service depends on phosphor-ipmi-
> host.service file. So it is cyclic dependency which in turn not letting 
> run any of these service.

We've fixed this: https://gerrit.openbmc-project.xyz/#/c/openbmc/meta-phosphor/+/16856/

Sorry for breaking things - I had forgotten about the KCS backend.

Andrew
