Return-Path: <linux-aspeed+bounces-3064-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37461D3B7EA
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Dec 2025 12:00:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dQcr34B6Yz2yF1;
	Tue, 09 Dec 2025 23:00:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=78.32.30.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765281651;
	cv=none; b=a1e8s0cYSA9ZppTsRAk/ftPvW0J0K+A3hsvzxDPQV7nszVxo9pRNniq+s9+SweCc0oQoe0ZRWIGqloZeZxsEUjCY0VbYJ3VC7sZs0fBY7KW7rl0JuYpT7BXew0ATfNbYvxhxKIRWzbHsUprUcwvWWSqU5L9PxAbOVVMPE4d1DjeXLvjT0WVwIU/ZD+DTDf9JRTLl54yIMVIeD8kSiwnFTRPn9mjbU9oAVMUPt/Fw3YhQAWQCFI9AOLJU+iAgNVMNoJZ/rhhixRRx3aZs9GtqN3r/GE1l/tVuIKFcNx/TVpJiGm4PKBHCZgLK4a1rQJaMdO5VEV2jjiNIrGwZS/p+WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765281651; c=relaxed/relaxed;
	bh=DwKdmCUbXETjxy9fokPP+UnDSthHBd6FAyICBa61gQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN87adsRUbSmN8NYFJAVUZwhKPtCOzLmMtT941IjXX5nvbg6o4RqT0hqD0/yfoHd8EYVbMa8JMek9Lg5iwnFZKEl2zFdLbgQEvK22IzZgLf2iIKEV+I9HJH3st7OCV/VtYhZClIH28OxjnzmpefFsOue/S4blgu+nDCbFxFYWoka6WTA9x8Xgwi9rQz92Bdtc6dL2d9UADgvBOaF9GVvDzBvZsQJBN3bTgCPvLinD0lmmIQ7IfGKUc5/ObbvqQiIT9VaOe7YRDSCg1gJae+aJT8WK13tqnVOq8MQWhT8dADWJwutcbLE0OBfoF/x5ujdnSasq/HrxWZuKo6YQlxu9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=D9rFHetJ; dkim-atps=neutral; spf=none (client-ip=78.32.30.218; helo=pandora.armlinux.org.uk; envelope-from=linux+linux-aspeed=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org) smtp.mailfrom=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.a=rsa-sha256 header.s=pandora-2019 header.b=D9rFHetJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=armlinux.org.uk (client-ip=78.32.30.218; helo=pandora.armlinux.org.uk; envelope-from=linux+linux-aspeed=lists.ozlabs.org@armlinux.org.uk; receiver=lists.ozlabs.org)
X-Greylist: delayed 1804 seconds by postgrey-1.37 at boromir; Tue, 09 Dec 2025 23:00:48 AEDT
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dQcr02Z6rz2xs1
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Dec 2025 23:00:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DwKdmCUbXETjxy9fokPP+UnDSthHBd6FAyICBa61gQE=; b=D9rFHetJk7ay/DXTWcogtOMRUt
	jy1aVrj+NO6xKIk/M8evsvfydfIZJbYw5Ui+Ujn56/7VBa305YJ9I7tF7Rtd+9Yr1dniHavtI1T+J
	sWcFLnp2VymQ0Ze+CS0nFMDv67CRoP0GIL2q0izyU6yk6GwFYSXMqyF4PZKzrdEhZKKIL+fM1Tcmf
	uajhTlqMaBxi6tMsohBHsXEkWI+D7+HWVpXqc9TaX4mZpY71tyG6ualnvhbg9oEo2Vfl8NS4fcZdk
	4zdhlgTxaqpZXtjYRbmfefhLWrvcEjUh+WsNaxL2SLa5xXbs3D7yZYrmRUqclUH7fNT8haY2vupJ6
	GFS6nqQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34968)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vSvsw-000000000Nz-0ADF;
	Tue, 09 Dec 2025 11:28:02 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vSvsr-000000005xz-34kQ;
	Tue, 09 Dec 2025 11:27:57 +0000
Date: Tue, 9 Dec 2025 11:27:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Potin Lai <potin.lai@quantatw.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: mdio: aspeed: add dummy read to avoid
 read-after-write issue
Message-ID: <aTgHva-UVEPl9EAR@shell.armlinux.org.uk>
References: <20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com>
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
In-Reply-To: <20251209-aspeed_mdio_add_dummy_read-v2-1-5f6061641989@aspeedtech.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 09, 2025 at 07:15:31PM +0800, Jacky Chou wrote:
> +	/* Workaround for read-after-write issue.
> +	 * The controller may return stale data if a read follows immediately
> +	 * after a write. A dummy read forces the hardware to update its
> +	 * internal state, ensuring that the next real read returns correct data.
> +	 */
> +	(void)ioread32(ctx->base + ASPEED_MDIO_CTRL);

What purpose does this cast to void achieve in an already void context?

We have plenty of functions that get called in the kernel that return a
value which the caller ignores, never assigning to a variable, none of
these warn.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

