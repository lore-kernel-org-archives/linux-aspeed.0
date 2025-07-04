Return-Path: <linux-aspeed+bounces-1630-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08464C83030
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 01:24:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYGC73xNvz2yFQ;
	Fri,  4 Jul 2025 11:24:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751592291;
	cv=none; b=Nloe0pfYPyHgm03fA61QHQT99LEdQ+FvC2zJkAxVcP6Ks9olbO0z+0zXQGHGoxEvRD5Jc2MIyMZZIZKeHg+ERy2LhLG/H3bevQaAdWJvccWuorNGVBgMGcGLutyJXn1UJXyMHttIvfgcSyDQ+5rf02FZ+fSDI51k2ny1vGEmTGxsOPeVjittVzuxGuyVBv3wYCZ1YaiuCaxpAuB6AGf9vlh9JNvWawSRVJRo0r+j9DXIC5uKPcL6um7B/kg9HZ8UVr8GWB47/lJUIHEqhSDs0i8Z3M2VkghGrSImseDlsfhxRqwGh18jbGckyEX/RLvoa40wEqJXlCq/AxyB2um9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751592291; c=relaxed/relaxed;
	bh=dmVwpc0egoHaQe36uq5tr8rwYmpYq7GIAe9eeLMQKLc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UnoCRLFpuMqGvxeYZ28dsg5XeGyoIE7i9xZbpR2hS85P2Oms5f0pNGS1PLqtLzvIQs6CopJvSCihxu29G18Y53xxC6lXg33KBOg/7wN9PpqEdrYopz6NOZONXUCKdRZuraOYB7vVXpCq+RdzseVRyrSNAwBeumyA4fZM9HJRafruDmZhIZbqoJyEJNkUbxuIPjHa7vxUSOGK2lOCIqR/4biYtrCT2qHxk+z56c9/1aLtt9PATL/2fG+049Y3APINL19rykq4CyNLsIoZ2QJGj5yAWZS7aUDIO392sT5v/pXj9lpNTCWuhOToARUqzMEo4S3TF78aQnVSJHlGadhnoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=I6is1ers; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=I6is1ers;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYGC66WCKz2xS2
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 11:24:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751592289;
	bh=dmVwpc0egoHaQe36uq5tr8rwYmpYq7GIAe9eeLMQKLc=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=I6is1ersaoALURA73JjjX7SMm43rGbIhpvpBNzKZRZuDY4wEbdLiPSBxdCNamI5ZA
	 7Ft6POqmfNCzi6eF30kD+OdQWsJgKmnQ94fckvpDCQ+ByX5wv/JsoO9wNvvJaphd70
	 qOpP5m4yDOPF//pl+HAxxyRgeLy6/oGTS9uAiPCN0wf39X6FlQta0CgHNSaUQm10kk
	 BPVl67+Re4njKhtMqDPieMT8eObg6RdPJ20Mx9fynkLpknkRKjV491IW+om0BXlDY6
	 Y/QKwLyjVTtC80KCyFcodX3Hls0py3vnpM3Bfc/tfJvD4k5cmbuJ1FKdMPBtNqi2h9
	 kI/sXIGRrczDQ==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B5CD66443C;
	Fri,  4 Jul 2025 09:24:46 +0800 (AWST)
Message-ID: <444ea7dd85b7e664043e3fae4a22d515fd121433.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] mailbox: aspeed: add mailbox driver for AST27XX
 series SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jammy Huang <jammy_huang@aspeedtech.com>, jassisinghbrar@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Fri, 04 Jul 2025 10:54:45 +0930
In-Reply-To: <20250702011956.47479-3-jammy_huang@aspeedtech.com>
References: <20250702011956.47479-1-jammy_huang@aspeedtech.com>
	 <20250702011956.47479-3-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Wed, 2025-07-02 at 09:19 +0800, Jammy Huang wrote:
> Add mailbox controller driver for AST27XX SoCs, which provides
> independent tx/rx mailbox between different processors. There are 4
> channels for each tx/rx mailbox and each channel has an 32-byte FIFO.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

