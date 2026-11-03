Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C011606A324
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Nov 2026 04:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Npe4O3xe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJZgD3n2kz2xN4;
	Tue, 03 Nov 2026 15:03:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793678600;
	cv=none; b=ZK/V+4oOz89nTIxa8u0dvlq9m7bV7/LEG7bik3z6f4BcdccJlfvSO3aiuCbhHhejoC6gYS5z93qOJUDRCQ1Gqj5F08N8ymoAM15v1P7QHrtqS9LtIMfSfYAwPVfDj0qXPdqkCGZ8jkCUbjz9d5wuhvfKJaJKBzeBgeTy4JBbBc3KDrojFaz4l50btbJGp8pVdqRy5qW9YUSKWh1z7e6WjELIMVd1nhjHje0mSiPXNsvFuS53em7BOyhO8JgWvcjKKBJEMGPhIM6ZwVCjjqKkYH+If/C6S9TFGWVDnUdddVEqdWyMvKRO+McCYSFl3a8IRc11mt+6O8LneoIB98lbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793678600; c=relaxed/relaxed;
	bh=yNJx8chMtCeXWl3KaKPCoTjErBK6LBENXJ1CL8gOBQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=glR7wl71ZEBjlvX9zcmqFMAicEGB0rM+TPUQsDiofLjKh1d/aenuCHVNdriIgff7p9SPXmCToEQjp7r3J/PdNDz5p6LaD4I12cJ1vGWCROA2iEHZmbifIeHy1xP6dXB8b5qx/bno1c2c3FpTqYK8QUVMc+Bb/XGX4jI3DDK9RL5lCwe/YVIkeSoyCE0yBotbgNySWKvTAubyjeEk+zfUZX+OV5ojf6P6ULKhhMc6TgREyZvapyCRgZnHqNDc+fxrV+Wg7CZW4rJVQA/iBte8Mdha+d1jyXPrM9BTAD+QgEWGro3IH85vWARtUGUxHQSq9qoauGmEzplSodadDSWSpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Npe4O3xe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Npe4O3xe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJZgC2j0tz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Nov 2026 15:03:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793678596;
	bh=yNJx8chMtCeXWl3KaKPCoTjErBK6LBENXJ1CL8gOBQw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Npe4O3xeYxRZuIM87r/9x5V4rBpQSVBCgGV6mk7gq3kbDkL/S0wT6UTQjZHBgXIGx
	 G0IGxrzyn7CLHJoAz6sJJ2oIG6ZYTwaflbL+XVun5dVD53WijDZrWzq/RnreHULCIE
	 e5PHon+J5EJ1VTWLHxNRyrzZ3cVRjXUXfyH5FsjcP2a4InCbnmraT/tWfHf6gSfgOq
	 4YDsAqhu38jXBvO7puJKxb350JpepTXxh6HhZK7mtWjEIaCMgEkcx9Y9ZKQva2hJzb
	 M3UsivRIBumoJtGZYOZ+hM/TEKnItuw84iH+9aaqhbBFlnuhRNCEGfYcoh36b9qHTN
	 5kREQmUaQnmJQ==
Received: from [127.0.1.1] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7114B648BE;
	Tue,  3 Nov 2026 12:03:13 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Arnd Bergmann <arnd@arndb.de>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261029-ast2700-evb-reserved-memory-v1-1-ca1360d585d9@aspeedtech.com>
References: <20261029-ast2700-evb-reserved-memory-v1-1-ca1360d585d9@aspeedtech.com>
Subject: Re: [PATCH] arm64: dts: aspeed: ast2700-evb: Reserve coprocessor,
 IPC and VBIOS memory
Message-Id: <179367859374.59456.14319284457238248837.b4-ty@b4>
Date: Tue, 03 Nov 2026 14:33:13 +1030
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 15:51:54 +0800, Billy Tsai wrote:
> On the AST2700 EVB, the boot firmware places the SSP and TSP
> coprocessor firmware in 0x42c000000-0x42fffffff, the IPC shared memory
> in 0x431080000-0x431b2ffff and two VBIOS regions in
> 0x431bb0000-0x431bcffff, and locks these ranges so that accesses from
> the Cortex-A35 are blocked. U-Boot does not add reserved-memory nodes
> for these ranges to the DT it passes to Linux, and they are inside the
> memory node, so the kernel uses them as ordinary RAM and the EVB fails
> to boot once it touches them.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


