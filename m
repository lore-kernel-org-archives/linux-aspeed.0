Return-Path: <linux-aspeed+bounces-2195-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96964CA101F
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Sep 2025 12:56:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMLL26vCJz3dBh;
	Wed, 10 Sep 2025 22:56:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757509002;
	cv=none; b=lIf/1KBu0+rfOKOF/gWIQfJdFHdptXMiFHLNa4FLlIDIPZsy9O7Gg9q4+OwBO9R/OruirdZTJhDKVQdT2qmo/PfDLX5GuendiAk7ShBtPva6uGbUxqEKY/NLVVCBIqTH0HH/Zy+bSW7uTCwV7+QpnQKLoBayV6bH5rGdkIhAlvulCmV2liZq4dgAjqi/yxUPWfEdpYGd7IfqTEvfKf/H1UU34pJ0nlXazxPALToyLPnFn0IjEu45QNa6j8oNB/eI8QKiqurYN57dxWPjP9LK0BgPJltDDzqxQkj6zGJgWAkXQtaEdCAWLjN8xo29SLv8SUJflLNsTtBufIn8nBDV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757509002; c=relaxed/relaxed;
	bh=8TgsJAPG+gvJuGo1mADyM4jldixKGYBoLgCB1sss4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PY1nphIaN7IUIpgNFFfrQUkaqCnm4bWwuPw7AKGVye5el+lPW6SNtF0U1T9MwVeGbL/0TJspn5vJOku3XNjQsU2P98aeddg5zGNdJ9JQvPu6DUnD+wXJzERtX2vjrbu8xz/Nl+QWLm7f8vSjbmhSXc03/aPHJCw2mhhrzYM8HkiEHPfodFdEsjqrh7FG6D32u0rpDaeXg09JmkEvAwmPVQfIn3wD4OSN8HquRRrggSxFYmBCq+jG3yqL1sIdI29QASjv+kjup5aM0r/waH344NyEvlhsd3SBSKi1SU2/uzKjmuTrR1GdLy0Sc8zacOZRmX+uxvg7Ku7E3d1zB/g09w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lkR1tk78; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=lkR1tk78;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMLL073kvz3dBd
	for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Sep 2025 22:56:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8TgsJAPG+gvJuGo1mADyM4jldixKGYBoLgCB1sss4qk=; b=lkR1tk78PoV+Tma7HPr7R4vg4F
	89G9DYvsE0UEMbP3/X/fB068fW1Iba2c7JfnYajxoZlZ7vXiPSUusxi4rdETc8BwDacD0hfzRWikb
	F324HDIyWpZl/15fv3FvAq5siiiSaVLPbOmBefKd7SYlI8uqISsyAdq9a5wMbuSPg1Ss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwKN1-007wR1-Mv; Wed, 10 Sep 2025 14:56:19 +0200
Date: Wed, 10 Sep 2025 14:56:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add NVIDIA VR144NVL board
Message-ID: <3114a51c-47a2-4b67-8965-33841ee87fd5@lunn.ch>
References: <20250910040601.240162-1-donalds@nvidia.com>
 <20250910040601.240162-3-donalds@nvidia.com>
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
In-Reply-To: <20250910040601.240162-3-donalds@nvidia.com>

> Changes v2 -> v3:
>   - Removed unused phy-mode property from mac0

> +&mac0 {
> +	pinctrl-names = "default";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +	status = "okay";
> +};

Oh, fun.

Please don't do that. At some point Aspeed it going to clean up the
mess they made with RGMII delays. And at that point, it is very likely
your board will mysteriously break, if nobody remembers it is doing
something probably no other board does.

	Andrew

