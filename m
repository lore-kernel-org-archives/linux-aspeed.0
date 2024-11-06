Return-Path: <linux-aspeed+bounces-90-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F3DD59F7C
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 23:41:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkMDj216yz3bcW;
	Thu,  7 Nov 2024 10:41:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730936517;
	cv=none; b=C9ciC8UngeuBmuIFIuSd/zZl85RzdTWPjpbOsaah5Mo+7c0W2zhzEScmNueNkjyK5GU8sYy1cNcRrXLFnfSm2PzugVTJiBG4/VeC4TWVVETm6QY4cz7zFvVabYb7NWue08aMGncyLlss2vSInYIBBq0h/SVy9ZE2J9zrhuTCYaEw/LgrZlUpcnihJqCeqqpYg7/UFfqkvhEugCYJbW4Ht6l9NafRGIaV3KUD8DOnSVqKpMGRDAMULVgu4Rk3xktFh4Jd5sBs2rQHWHeLhlNIEfdv4451pF5Od0jTddvVlIEuMrrKPoRFyDuBfdQL71iyu9Lck1nCd/FuZcokrYzTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730936517; c=relaxed/relaxed;
	bh=V35WscTPJJZa0kbCQI1v1lpPEhxmxrS3QjHONqjJA1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzvZ9e4mMK0XBDxMovTpGA6mLh/gJFqOIt2J8JhB6DVtv2lnPBfVZVTCbNdj3xIj49A/mpM8zbhVYw/1yZ29DXIV0d5Z7OidDps2OBuBUkNfZy/Wg1Pp05Lof7Cp42ogzEU4alePbgqbejxen6TsAXjifgBUiwaEm5+lxkdkBPnz5pC/QGmRTSS+L9nlbAqiPNY0I2iChfJYESJ7OcVlokJCyUggZwEOuRKg0Y1doJB4DY52bsA0nqs3sFnC7l4oki8hxwjLWVMQiOJmZ6F6gW5ChWSVosoQRA0YLLTlbGArJfcKi9f78apyrqOIhWxHE7PpQn72lR9/9ILf1bm2MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JX+IWwM2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JX+IWwM2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkMDh3g4Zz30f4
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 10:41:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730936515;
	bh=V35WscTPJJZa0kbCQI1v1lpPEhxmxrS3QjHONqjJA1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JX+IWwM2IZKC33djCGZllfdL1g6kzRmzqS2dbraQZ9yX2gxdN200kEeNQAPxmmw/b
	 3ZMLeAZDM+IUbU0IczUPvUIwlK6HBNfxcl9jnimW+gI7Jaj4ksKEPptl6vsCwcJ6/L
	 ppnYjq2NZn7T/gev1C9gOlYyPKpqbbYowo7vxCe62tCqYwkyUbK/GJfc/lBonbPuiQ
	 +d+NIVAYzSMPNg7nBfjM8+KNC6BrRxWd2rs/mTn/Yfe5UPGuLs/5+rCXQVYLHW6/aB
	 80pi1JjzLatvGOxIJ/rJvF9fpjD9Idt5igM0JL7oKKTnNpFoltR4hj5HzItHyUh9sd
	 lLSpdH2zzHWNQ==
Received: from [192.168.68.112] (203-173-7-89.dyn.iinet.net.au [203.173.7.89])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0F8706B4F1;
	Thu,  7 Nov 2024 07:41:54 +0800 (AWST)
Message-ID: <8e858e760c78ddf533e9e03c20b34fce29862c2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: catalina: update pdb board cpld
 ioexp linename
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Potin Lai
	 <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>
Date: Thu, 07 Nov 2024 10:11:53 +1030
In-Reply-To: <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
References: 
	<20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
	 <20241106-catalina-cpld-ioexp-update-v1-1-3437bcfcb608@gmail.com>
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

On Wed, 2024-11-06 at 16:58 +0800, Potin Lai wrote:
> Update the GPIO linename of each PDB CPLD IO expander based on latest
> CPLD firmware.

What version is the latest CPLD firmware? What was the previous version
with the old pin assignments?

I'm also interested in some discussion of the coordination between CPLD
firmware, the devicetree and the BMC userspace configuration. This
change feels pretty painful.

Andrew

