Return-Path: <linux-aspeed+bounces-1606-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D6C8303D
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 01:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX2SF2kv6z30HB;
	Wed,  2 Jul 2025 11:31:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751419917;
	cv=none; b=LQABbRzoxBG1wYxlHl0eMLdlQkHmpKctBBeoShT0Ny/mvZVkW/YPwKwOAmMu6Qgvc3lJZmaHIJpbqlxw4Dx8WC1sPQvOzEe7KWRxc+8pAezTi0lUfHvxl5Y63JimW9PF8hOJwPOEgPuN85LGNPOqx43kLxXyvw4Zojofs/8zHHAGGkVvuwQAUtfMNQeU0Jwum/898LtH8BM3V8U3Opv8EWwRrO87twnmhKdzru+I3JlX1RhGgOSQp/ZWntGQn5xPePBqTOHfNIZjSBP0likn35Mi/T+G2/uqwXPbotQHOj+0zCp4QJzNanClBYlWaqEo9XO2/zZyUwkW77ujfwhZKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751419917; c=relaxed/relaxed;
	bh=hk7ZeiYwOz40YUch5aVMcMHStH9+6Z54QC+hnbt5LbA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=lAYL2i5xuMbr0EtywkbUXAO+Vdo8ZICsRR2O9BV493JXVoVM5xsCiFSvXVWDRrrsL2LU01XZiR5o/+7fPem+OocYsGwLaE03Q2UvLWjVvDC4/UdOANZFRuNRj/zOwR0HzIlx0JrWYe6tfrj4xqmhMYjRMeROBK9PLoGHxTt6PLDB4ooW/u9VYBqoGVkjKvjxG48VrV79F5R0hCy9fIe+ozADYycd/lnXudkI8+0WdD4pNCJGJlNzUGHaDquadND8HrkiYtBJzH3ulsViGDPXMFN/Is8Alqxe/WN62fK+8KyeW9mcgae3Uk08b6bINXXnDtWsHLsmNkrzoZt/AwhrYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bu1mHB8I; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bu1mHB8I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX2SD5zF5z2yQH;
	Wed,  2 Jul 2025 11:31:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751419916;
	bh=hk7ZeiYwOz40YUch5aVMcMHStH9+6Z54QC+hnbt5LbA=;
	h=Subject:From:To:Cc:Date;
	b=bu1mHB8I8dJgGgzFe5UcIwj7MQrDplM4UegN72H849eg2IrW5EJ7liLZJUGV3dviF
	 nc/KBxwSK5WtusXVtuXDYq51qxDggLwJ9GEoni5L1cZ6jY2mB4Xbjwd4ydKMKA8UNR
	 HkB9hApAPik3yjT2aPgHFjVxU0EMXf8lXw2apMdpT+TGbppozANseIpvmJuYCQh6+k
	 8YSN2/+qaeUDVhijB2SZjxwGsEnGnHUzzPoz+KNrmcyiTaYQoJsYWr9bMKK4udqtn5
	 TIwTuT5oy6pw0oaIqGzKRiXM0tr4hSJiwyxH+DlmP365l8J/P8jfCpNYyS3tH1kRBF
	 T8xsOpQt8E/ww==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CAFFC640B4;
	Wed,  2 Jul 2025 09:31:55 +0800 (AWST)
Message-ID: <2ae27beb3fa9266e8f73cfa10d8299465d872183.camel@codeconstruct.com.au>
Subject: Add bmc/linux for-next to linux-next
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-aspeed@lists.ozlabs.org,  openbmc@lists.ozlabs.org
Date: Wed, 02 Jul 2025 11:01:54 +0930
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

Hi Stephen,

Could you add the following to linux-next?

   Repo: https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git
   Branch: for-next

This aligns with the recent patch to MAINTAINERS for the ASPEED tree:

https://lore.kernel.org/all/20250702-bmc-tree-update-v1-1-c270cd8af0ab@code=
construct.com.au/

Cheers,

Andrew

