Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A2606A884
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Nov 2026 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NY9/si+Y
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSlJn3f36z2xtC;
	Mon, 16 Nov 2026 22:00:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a0a:edc0:0:b01:1d::107" arc.chain=pengutronix.de
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794826841;
	cv=pass; b=PXkXTIYxfCOkUHtBIM7CxzxGEe8S4/8hBpn6t43ugsNLQk+JN9ljAXXLPm4fe+TFxHzdlKPuZISHBom0sEOK2eNqq4PY6Ym1R0t5LfnXrM9UlroBiRAqUQ7SPrMFZhY00d558LsOFXZWDAf6kpfLQvYaFIjei3cZfylrmgTfUb+dJD0rdZWUTwTMh5rMcQawgP8hMbeY+Ji6L/Mf5P83EQ+cbZPjK6xMu8y+6hOBL3PIt8QpnUcfHMLOmeTjMvk570PcBpnOlAWd/HFrRWNPsB8mHCuUiANfdS6x0TYFo0TEAHjy9g8j+Pqjs7zNaEKTzlk8xjbV4AbY9xw99Ega/w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794826841; c=relaxed/relaxed;
	bh=aJM0dawyH8gXbWmqX0nGo7HUQ8+upl7nxWuHmU22MH8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i9hMAtHl7996dggTiuul7TUYhNyJIfSWZQ5i+pKB4hVUskGWiEDIdaO2n+u798xmUnp86aolxeMG0Rpk+NFgPwhhmsWH/FYmCesmzhIRDloEwUlPtIqDmWXgCbn1mSEM8XmOaP+UCdg5Ue8uJ90i++mcw9JThXqtQFEyMOr2Z/Z2FegDCqaERDBfoxxaXXABlkh4D/UvEKfvATr7rfXzKtJTRpSsQFOz+ATAWGAlt8S0oCPLOrPs0R6nGbic9Fvua3oVDYYsj/U639GnOa1Lvwtpwrsp6wHDH6idOOonjHPTizjruNLgdThgqlpDblfz6i07PiymsayxDyAKZ6s8SA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NY9/si+Y; dkim-atps=neutral; spf=pass (client-ip=2a0a:edc0:0:b01:1d::107; helo=mx1.white.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NY9/si+Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:0:b01:1d::107; helo=mx1.white.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [IPv6:2a0a:edc0:0:b01:1d::107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSlJk4KVfz2xnn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Nov 2026 22:00:37 +1100 (AEDT)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 64BE82001E8;
	Mon, 16 Nov 2026 12:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794826832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJM0dawyH8gXbWmqX0nGo7HUQ8+upl7nxWuHmU22MH8=;
	b=NY9/si+YW84m+SS5J42fHf5A73xFx/MS++ISlMVs/Lmy84ooe4ApSUZeHakT61dxlJs7mM
	0yoYDEteEAFt29328JOeis8SVgQkzh+tvl9uc8WUxX7JRPVDQ+hQ8VSUTfdCxEH0u87Nex
	otO10oTjG2j5YhzMbQ/MOlCaIfJadzxiAPzPtYPc8n4OKsM4MiJI3ENmUH+VkKLlyXa7gz
	xfmg7hVf8ijp014JSRExXacJX8XnpfGVpGoOZxIRIk8n/08Tidchzt1Xz8R7b1swO1pSlT
	SDxhDAOClBHo2heTAWwennxo3khY3exT9p/VpkL8u75hfG3LOPY64VWuqefBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794826832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJM0dawyH8gXbWmqX0nGo7HUQ8+upl7nxWuHmU22MH8=;
	b=BpsYkN0qtdfxnjyNg0TugXXbCP0r18Y2MTiFvJQ8bzJ/gw0J2NVBu2X1NoOxGVd8qPgsxj
	ibKMkFfhU29tax2fbPe4PzW/UbjZdYIdEH7cVMDuZ9S+1TBeTLataNXn0sqb4j0w0HoY1P
	VFm0Lf//UPvGoG3CfTIlTPFqhCSr19L2xJqmBUd0181CimoJr/UdPIiBQRYs9tnt5paQAl
	ibiH0jn8aQTt5UCb3oNaYQFm78D8+QAPL/eS+fVpGr+3olICBRsSwabA575BZzWZXJkuBB
	xNNzN6FrpqVZpQgzb8kR1VBWY+4g8m2ZhTB7N1IRntIkmwNIKXfawwWRSt+9Tg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794826832; a=rsa-sha256;
	cv=none;
	b=UxgYkZY4wxVdPW+p/h6wNa0wjVq9umd2QZCZv8vk2kdpWbJ7FYICcKYVx7AwmkD8P69tih
	SNzftfgQF1tyKan4mPdS+7KsB3T9Hc4JulJ/aPfaPE1aUlwqeP3SAy5ukgomcdka2Tk9/F
	CuX0/c7S2botvYurBUK39Z4fSI5ZqeG1vKAXeJmMHQviBYapzmYLPMTXkMkufj/+W0f7eg
	2mseE8l66fgG39F+I4MKtczsIGCBCpWrWJTfWImzJ2PiOdk08nwsvk0sgFNsBXUw4qPmJ+
	ajxmmQSpVq/eu8dSve8qDT0kIes//7CEPOGlMcfL0S/+Wb3feydjz5ccsLiLlg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1b6620f4c2cbed3124e5521f18585132d2e8dca2.camel@pengutronix.de>
Subject: Re: [PATCH] hwmon: (aspeed-g6-pwm-tach) Use
 devm_reset_control_get_exclusive_deasserted() in aspeed_pwm_tach_probe()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Markus Elfring <Markus.Elfring@web.de>, linux-aspeed@lists.ozlabs.org, 
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Billy Tsai
 <billy_tsai@aspeedtech.com>,  =?ISO-8859-1?Q?G=FCnter_R=F6ck?=	
 <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, Ryan Chen	
 <ryan_chen@aspeedtech.com>, Tan Siewert <tan.siewert@9elements.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
Date: Mon, 16 Nov 2026 12:00:32 +0100
In-Reply-To: <bbbc7228-cf98-437d-b240-ad29ee7fb4ac@web.de>
References: <bbbc7228-cf98-437d-b240-ad29ee7fb4ac@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sa, 2026-11-14 at 17:28 +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Nov 2026 17:11:34 +0100
>=20
> Use devm_reset_control_get_exclusive_deasserted() to replace the
> explicit reset acquisition, deassertion, and cleanup action registered
> with devm_add_action_or_reset().
> Simplify reset handling and remove the custom reset assertion callback
> while preserving reset assertion during cleanup.
>=20
> The source code was transformed by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

It looks like the reset_control doesn't have to be stored in
aspeed_pwm_tach_data, it could be a local variable. That is a
preexisting issue though.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

