Return-Path: <linux-aspeed+bounces-866-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C99C19776
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Feb 2025 06:13:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z3yZK2LjNz3brx;
	Fri, 28 Feb 2025 17:13:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740723209;
	cv=none; b=BcbnDUPqgacGEnA4Wfr0tg4F2nPSRbYuXn59zHh3pGTTM5zEkPZs0Fwskxe2vSxE+idtoDy5bREMleAtp9CGvp09JD1VeSl+4AmbIj0T0ZfvKGWEk/pQznPhE0PT1J8ZZ8/fHC7fS4hD/esy8wASNJGg/CI+1PLxcDcdu878LDFTxDDiifdjLIDNsjZn5VVA61eW3HgZZ2+lhb3yPW1wrG+TY8ZYyCAH7Yg3rxtOSlRZ3j+2vRhKu+ZKLZAeg9cfB2BO9PiJAeYsZ3QKRGU0lSYEm3me7/w48i4NyxBoDD7JBPQrTqnyEbjWVSk/i7sTQ0gaVC6DpzqK6Lxo5n/bhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740723209; c=relaxed/relaxed;
	bh=pp9IBKUNCA/ZJDCgfry7+1Ltnk8p0iW227IRYl0yOXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bnuAjIu1p7COpnaQErCBeLxvCQmOh7GTfho29aNDp69wkub6GVgClQqkSSBA1XmQZQtBXiozFl/l8C8sHUYuHxQaU2bxaI4vUfIL/J7rjPgL+MvO8ESc7TyhZ9udetYDRkfTKr2EucForHKhdAvmDwwRHKbSmEuEC8iRFiPPB+tPtjT/9sJH3itNuEMB2ObbR6kS/pxtSwBrhsls1lq3ZePGTy7ZzbpUELQMkkdN6HLCzIG6l+KnkvFl3MrAoQayFJ8VWRONWgkZOzrAJvcJAF2Zy83Lxp/EI08fk225ZHqh7nwte4/ZWTESOKuMgv/vlMHPo847CVESKqlrxwR7Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ditMs+Qb; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ditMs+Qb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z3yZH5GMgz30W5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 17:13:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740723203;
	bh=pp9IBKUNCA/ZJDCgfry7+1Ltnk8p0iW227IRYl0yOXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ditMs+Qb4Ve+EarpPSccKWAdGQWMzmrpNYywK6GlQojWc1Vahufg9xsyjz3kGCk5O
	 gIcp3/Sj7bJmQSNN1Y6xLJrBClGqr1UoSrEbSpYEnP2EkzRUjDZorc2M1SYpPqjg4W
	 xvBjpqq5yBPccr9WMXq7iAoNM72bd2XppoXdOiBbjXj9+5UHYsjhAKKGqD+KqIYYL3
	 bw0oyu141KURV/zuC5UdSEqIRXpyP4r6johtqrPaopw+QKjfhWEIL6jLgCzH7lw65F
	 wZ0rzC32U8Uc2MEcI7qET4/5vBwqKCO3yU1mHoO7QioJWAg0Hucx8Qx3rAjYykmMna
	 MSARqv1UkfSEg==
Received: from [127.0.1.1] (58-7-146-131.dyn.iinet.net.au [58.7.146.131])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 65FE977DAB;
	Fri, 28 Feb 2025 14:13:20 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: brgl@bgdev.pl, linus.walleij@linaro.org, minyard@acm.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 openipmi-developer@lists.sourceforge.net, joel@jms.id.au, 
 devicetree@vger.kernel.org, eajames@linux.ibm.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Ninad Palsule <ninad@linux.ibm.com>
Cc: andrew@lunn.ch
In-Reply-To: <20250204194115.3899174-1-ninad@linux.ibm.com>
References: <20250204194115.3899174-1-ninad@linux.ibm.com>
Subject: Re: [PATCH v9 0/9] DTS updates for system1 BMC
Message-Id: <174072320025.3245072.10865277615164271412.b4-ty@codeconstruct.com.au>
Date: Fri, 28 Feb 2025 16:43:20 +1030
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 04 Feb 2025 13:41:03 -0600, Ninad Palsule wrote:
> Please review the patch set version 9.
> 
> V9:
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


