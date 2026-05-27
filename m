Return-Path: <linux-aspeed+bounces-4134-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31158CD5BD2
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 02:39:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQDMl3qM8z2yTH;
	Wed, 27 May 2026 12:38:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779849539;
	cv=none; b=A0pvlGXjOwu2nAIqga/+Z7+dTIykZ0XImz2pE6ZwUTui56AMB9ZZiwZ0uF6GxhaCa8YIRblSlvHoGSwJWiJhE7EpoMB0UBRR089IFGNQ8DPdk2FEgw3CJXmRONjXmUDYwfV4Z6mAlsbYe4nIycsoi+GFY/H0cwHJRrl8gu0+Zne8PAvqUD94sTLHDs8hUser+vSAtQ783E8NIY4mm7OanfVrjoB5D8gGBUyLLlnSBZthHxgdxoikv4j46o4NEGxIVrZ98pg8HdPRmPt114npTvS+1bfuWv/OQeQ5T6fRflvzj1b/Vwzr6NWbvNNJCnHbPkqmLJRA+Ytk7bMoTP4E5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779849539; c=relaxed/relaxed;
	bh=s6X96fCiiUtZy7vCtG5EjDCaHqggdWfq0rJbxB68zFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RGwFswcfYEd9dAfGMDSxaLBsVhHopkgTEOMZktVtN1P/he5kqj4tLpr9XDiXoPLQnIgi/KyZFJtZsArSrgeP9BtLSY9jwGMlnyc7hSASAwhnXInK48KlbiMlNxLgG/bHNMHppcqzAehjuCvrcAkvsL824VaoBh1IZ+VrBaNCU8wcf1yFMHOwfKZjwHXweLdxWn2ZVDl+8J2R68tyD1Rj9/XB5p8JiPVHfDsM1CwTmhew4ZOHxKWOlVna6gIv28ZxPpHMJT7bVdjN6irazmmX2KrHQwH8hrr6bjLt0bpzcT9Bi/lxJqU7OeNOEoQynODBO+iPK6xkv58OTg5SL/z8Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DYB3eydz; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DYB3eydz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQDMk5X8Wz2xtC
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 12:38:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779849538;
	bh=s6X96fCiiUtZy7vCtG5EjDCaHqggdWfq0rJbxB68zFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DYB3eydzT8IPzY0KJPLgjOnUrH/Rci9Ku8LhD/2WsdQdlYwpjM5CHknmNv0R29sUg
	 o9evBWo298eQCyVVQVGPzQ8+FceW3/LBNvUkJbPuAU8DMpMEFHwsb++kos53dMWZMp
	 cR5UP2ClNYnNFx/irO41O8QmmkeLq733ef5gidPbfQxBR+X2R96WsYAwDt3bv3dDKK
	 erN9V3ueEEsxvQT7vDmiKR6fUzXgvP27RJi1wAGcn4JINXilLzILWtXjkwLu8tUSYz
	 JJD5Nmp/Dd4ZrUd5uKt7zpemnkZch9AFW2XouoOVPfpMEbx2ZR1J3vDybx2ItbQufk
	 NTEWXCoerO6UA==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BAB2C6001B;
	Wed, 27 May 2026 10:38:57 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>
References: <20260331-asus-kommando-networking-v2-1-f7d72ae5d40d@gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: Enable networking for Asus
 Kommando IPMI Card
Message-Id: <177984953766.356210.4909123426054062345.b4-ty@b4>
Date: Wed, 27 May 2026 12:08:57 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Tue, 31 Mar 2026 09:18:00 -0500, Anirudh Srinivasan wrote:
> Adds the DT nodes needed for ethernet support for Asus Kommando, with
> phy mode set to rgmii-id.
> 
> When this DT was originally added, the phy mode was set to rgmii (which
> was incorrect). It was suggested to remove networking support from the
> DT till the Aspeed networking driver was patched so that the correct phy
> mode could be used.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


