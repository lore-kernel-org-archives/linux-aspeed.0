Return-Path: <linux-aspeed+bounces-657-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD34C02193
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 00:00:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YngP61gX4z30NF;
	Wed,  5 Feb 2025 11:00:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738713658;
	cv=none; b=StHCDI8vyZ9QsWPXr2CXRjUjtmg8S7ncP3Yv4c5nqn2KuHHAfQ0BY8Zc6gGkQllMcMIR+szK2RRQR/J7dDUe/reDDbxKIZlGsmkHwFFO/CcLYfIoXouVL2cnbJU2Pdri6YDTb+vNcErlL5wP1EYa/N6q9kf9i9crjzGlHF1jntXVL+aVLNePgLoLd9SRdiQ1UDG7M/4DZpIjsnWc3Q24MQebtisygcvP0gZ7ttWt+fOVx89MwL9pz+KVGSqI/IZwDUoOuTkc91IqgzORvlaB2uIbXP/ypG/ibztxehiWXVqiiw9Il2CegBhcjqd3X2ceA66Dk/M89hYg8yBYrCffTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738713658; c=relaxed/relaxed;
	bh=GWQWzYt8utmoJ+vGnEmbU1n9a9uX+2dxeh0p6epdA/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwZDI/+y54nN5qiZRvC50+D33Xwi+nXV8fdww7ErI8JBG8wmM1sOJj3x5/gH0TkW4cCkl+XqK6GPM+DkoMaj6M9HIF8cQZi+uVAVdIYmOFNHVjnWDuBkfJ5rWyaWpcbVymlk9IMEf3SM8s77ietTsitvltMJo1j+6YdaPsN8ycV6gbeKuFcZ0odndFVnJi6m6edxLOk2rK5bUqAqfbaLa4K0xpUTfbCqWMy2SL08uCmGgUTgS6dTlpUyu64iDNg3/ar/hdzdMsz44JQzZ5qUuaDUopXf0z88/D02CEbqT3291MNFyv0LSyEZDprYAKU4RP9poPbFERV5QJlfrQhWog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G5V0byMa; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G5V0byMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YngP55D1Wz30Mn
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 11:00:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738713657;
	bh=GWQWzYt8utmoJ+vGnEmbU1n9a9uX+2dxeh0p6epdA/g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G5V0byMamZKCiKzf3lArq4TYeY5xEWC8oOt2fXx/T04duFwgkWOGBbfVgQcbMEZzZ
	 ehkem+9oG4eutuRSWau/YSE9SkJCh1rQ88Zey+Eb9cX0nTpHYDwpSKxkCNJrynFyAN
	 VCE7DcFnp+8JO0OXy0CFmvPzc6Q/jSdFqjIdEYvPiExZXmyPrTUHI25vrocZJoeRJl
	 AUU57qZK5Jx6FzqmErxeDMKftT7YaM1cBJ1Fjjx/i7JNMKCn5Xx60vDAG90IjA1XfA
	 jt9FaxFYR+p18EJ1dFp0WFLxoaRfWYtaCVzBdm+vGHPyiL4kXPdaNKeSGchkbAdtY+
	 FD0cpUz4eeelA==
Received: from [192.168.68.112] (ppp118-210-185-209.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.209])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 992C37104E;
	Wed,  5 Feb 2025 08:00:55 +0800 (AWST)
Message-ID: <fd92f75620e48957c2875cdcfd1285c33d3176e6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 1/9] dt-bindings: ipmi: Add binding for IPMB device
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org
Cc: andrew@lunn.ch, brgl@bgdev.pl, linus.walleij@linaro.org,
 robh@kernel.org,  krzk+dt@kernel.org, conor+dt@kernel.org, 
 openipmi-developer@lists.sourceforge.net, joel@jms.id.au, 
 devicetree@vger.kernel.org, eajames@linux.ibm.com, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Date: Wed, 05 Feb 2025 10:30:53 +1030
In-Reply-To: <20250204194115.3899174-2-ninad@linux.ibm.com>
References: <20250204194115.3899174-1-ninad@linux.ibm.com>
	 <20250204194115.3899174-2-ninad@linux.ibm.com>
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
MIME-Version: 1.0

Hi Corey,

On Tue, 2025-02-04 at 13:41 -0600, Ninad Palsule wrote:
> Add device tree binding document for the IPMB device interface.
> This device is already in use in both driver and .dts files.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
> =C2=A0.../devicetree/bindings/ipmi/ipmb-dev.yaml=C2=A0=C2=A0=C2=A0 | 56
> +++++++++++++++++++
> =C2=A01 file changed, 56 insertions(+)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-
> dev.yaml

Would you like to take this through the IPMI tree? Otherwise I'm happy
to take it through the BMC tree with your ack.

Andrew


