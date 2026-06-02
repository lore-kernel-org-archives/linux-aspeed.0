Return-Path: <linux-aspeed+bounces-4155-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A525CD6E57
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 15:49:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFdN0Xfmz2xLm;
	Wed, 03 Jun 2026 01:49:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780415383;
	cv=none; b=ArP1hXqlTFeYmT4oejp5+uKyZb0zC7ST4yKg/+DA/jnolYIcVh8YDG2bDlimBJ9iv10a3VxuRU28D7Vs2K9fTmeoR61tcrCCt+tYESnYJOqusYNi6ttXUjW77SWiekcynzzOerY1V4SIzNRaUJPBp+kQ29AIepJp7TpgBGjKHvlNRqCvAduULW0twWVqp4BGPw3zTbpyQynOuxYgjmAuS5YTYNm3CjAIsNy7nn8L8zM/Xw1Kv3EyHi6TcDkiCXTqE+Yr8FY6rKThr+qboDG9NotYYGYoqIIAEuve4p+YiyTIpfOpH5EcR2EtPgIzZYjjMf4aPFcCUP5FiVI8yrETzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780415383; c=relaxed/relaxed;
	bh=CmLAuu1dz6ogdVEDsfDy7WMXAGwx2zeUtPl8MqWKjew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP6Yeu+bYMqYpASTWvzDJsfLdG5CbRNSEx4Rk+/A9bJZA2f03fl/ZMdXEeumJ71UsHs729sV0Dl2dPPt4pbfaKEZSCVrIaCilCFK1Uh7Xbwskj5sKE3jo1+8O22IeSwkAWuCQCeQkvSD8pJwEtV1AJ4ZIKc8Vuh7Kgl6DECDFw55qZa+9P4NMidCj6WQ8tH3Lvd6KZsmOS4q3ESIPMk48sBKup5CdOgFVHGr96FY5/S5DcPGFC7hza3NPE0dUMeCno0kLZMtwJdROrSwsza2a4qTpdtbGetsbhk+zyiWX4UXbb/evPA/jDRjZZap8ZUdOibGBHe899GunxoPOa8fAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WrLns3aT; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WrLns3aT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFdL4Ltlz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 01:49:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CmLAuu1dz6ogdVEDsfDy7WMXAGwx2zeUtPl8MqWKjew=; b=WrLns3aTSv1A8CkS/ZsErx+m2T
	btyk4KwUw0bTBCE3txgNbpurvS8Rx5Zvv7uaw3V22TgDMjvpUQzKzpXcBt2yuubLv4wWdX1eaVwWb
	o2BAzHi7Aa+xXUZQ6+y1YYiH23GFrhcn8sa6uX3f5e9quGJCWZt68UVqJtuozvQku5X0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wURMp-005iUd-91; Tue, 02 Jun 2026 17:49:23 +0200
Date: Tue, 2 Jun 2026 17:49:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Gr=E9goire?= Layet <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com, ninad@linux.ibm.com,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] soc: aspeed: add host-side PCIe BMC device driver
Message-ID: <ecc3bd49-829f-49b8-b3b1-4f16363ea5b9@lunn.ch>
References: <cover.1780409151.git.gregoire.layet@9elements.com>
 <a8e1396af1b6db38bab13383c6ba303e8427aefc.1780409151.git.gregoire.layet@9elements.com>
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e1396af1b6db38bab13383c6ba303e8427aefc.1780409151.git.gregoire.layet@9elements.com>

> +static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev)
> +{
> +	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	u16 vuart_ioport;
> +	int ret, i;
> +
> +	for (i = 0; i < VUART_MAX_PARMS; i++) {
> +		/* Assign the line to non-exist device */
> +		pci_bmc_dev->uart_line[i] = -ENOENT;
> +		vuart_ioport = 0x3F8 - (i * 0x100);
> +		pci_bmc_dev->uart[i].port.flags =
> +			UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +		pci_bmc_dev->uart[i].port.uartclk = 115200 * 16;
> +		pci_bmc_dev->uart[i].port.irq = pci_irq_vector(
> +			pdev, pci_bmc_dev->msi_idx_table[VUART0_MSI + i]);
> +		pci_bmc_dev->uart[i].port.dev = dev;
> +		pci_bmc_dev->uart[i].port.iotype = UPIO_MEM32;
> +		pci_bmc_dev->uart[i].port.iobase = 0;

How virtual is this? Is this directly accessing the hardware via
shared memory? Or is there software on the BMC which traps these
reads/writes and responds?

But first we need to decide if this is the correct architecture. The
alternative is rpmsg or virtio. There is already tty/rpmsg_tty.c. A
gpio driver over rpmsg is on the way. I2C has been discussed. There
are plenty of virtio drivers, console, i2c, spi, gpio. virtio has
higher performance, but also requires more memory. rpmsg is more
suited to slower devices where memory is tight.

Either of these seem like a better way to expose resources of the BMC
to the host.

       Andrew

