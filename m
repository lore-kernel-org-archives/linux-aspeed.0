Return-Path: <linux-aspeed+bounces-4064-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB007CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 12:13:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJxXD30PCz2xpn;
	Mon, 18 May 2026 22:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779106380;
	cv=none; b=VN6CVin+FEPoVS3CuvuYpgQkmpKaNYjJ9raFm8+VlzA28dx+nHKJDpvmQkemtL4CdqPYpHKuNhqyugIUkQnzaQCzTPweYuSbboPB3TaQTAFcYJg+rrw8tKvAwYwrMeW4C22c34EJh8zuUCAvOLSXgJFhpLPqMYusnvCVz+i3xtDEEJmVq8G1TJ0udUxpYv8dud8smNQsa0cJaPDrLa6FqPk3E4cDWGSzUkeqkpjLaD0Z4x7KtYJXrMCaXMTiESv0pXfVfE5rqw8ACy8mCv1e0kF+zN2+rbEHEpmJc6klpR5O20azphAQZnVnbs9zNuzSHG4cNiIK8h5CHIVYaJjBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779106380; c=relaxed/relaxed;
	bh=8+pg7I8Mbwg4j0XO5DjLnEMwVuYoSblXIRe51x3rQuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8VQRM2TFpH2lVLmdftj+wdaTn/mEdBvEl4gykeIO+XPC5QJtoZURJDb42lII9vRvrteIHaakInQZyb3Br6TMj06I+cmIv9qV5Or/jXXxG8w5UQ0VaGVbl6qAcjeMsAu+F0LuK3P4xxdVp5YKaYaiPjqFNWtZa/0Qs8hlZsLkva7c2d0614Ax4W2tOuAyMHtfB0t5U5C6kdaVR3QqRWjiPJ0OR7wstf6/MlK3QwIiq2x8+KkbrWapw5L9DVPkPsd7hyESJqkrA79Fh9/JrNtaDRakye9zI9o3o++dnVpllixz6H574P059eYR93weOyBlnjXeobVmMrkKHRAOhXKSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=h6zoxgCf; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=h6zoxgCf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJxXC3Gj9z2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 22:12:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8+pg7I8Mbwg4j0XO5DjLnEMwVuYoSblXIRe51x3rQuQ=; b=h6zoxgCfEzO5HKeM4/v8EtMWON
	whcBygWdkmhNKwZCFsl+iokpvANX/698CIKgRWqNW88Y1fgmNUxMSKfaaBrIKSjqZNaobeZzcVXJN
	ivkjIstgzb8zRMlkJ6VM7s1Gc4eGegr+SuJ+FDnGMQCRYShuV4BKsdpZmTmqr/kYZLLc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOwpt-003UGf-TX; Mon, 18 May 2026 14:12:41 +0200
Date: Mon, 18 May 2026 14:12:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <ddb781dd-e117-4f9a-a5a3-94c192d8c2ef@lunn.ch>
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
 <20260518033440.17569-3-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20260518033440.17569-3-prasanth.padarthi10@gmail.com>

> +&mac0 {
> +	status = "okay";
> +	phy-mode = "rgmii-rxid";

It does not matter if this is what the vendor does, it is still wrong,
unless you can show the PCB is adding the delay.

   Andrew

