Return-Path: <linux-aspeed+bounces-1626-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE054C83F03
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Jul 2025 23:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYD7564jNz2xJ1;
	Fri,  4 Jul 2025 09:51:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.37.225.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751530600;
	cv=none; b=T+cLXzACNvqwRNmewaIbL8uhV8NVHEZ8wM1mIOKFRArfoBH3Md+T7r+dPT64mxqirnxGSaIQlrh8MBHkt640up30ozeNS6phGottQc7agtFxrPu4JgG+7syo5gVfHZjLdw/cpbVPoTSv9u9ytLkrJVDQ7wnrN30dK1sBrZ8LHMA66w/EDG8u7Kyt9kwEpKNnm9Y/acIpOLu/VfdXtUzBAJme9x05s2O8YMy3dHmulDfZtGgMknPUUK6M6dalTPNdqq4Lat5t7ZM3KIlknhYqx4nD0rDA6E/TpbwqA5qnED/jzhtiMjdXNQgGmEf9v+UsZuJDV64VCWtKTDrAo6V5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751530600; c=relaxed/relaxed;
	bh=hOfcRWJkznhN/l+zfpnezOZxK7zE+eLHRMW/owZz45w=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=Qprs/FzttwdwB8CO323H3BO3Ibad/mru1MbAdynhEFErkXkC2GxApiU2RVFWjo4V6wh/qeLhgx6F+QdMC1DzGAw2kFV0zRN56VQ4u+3mxl6pok1WZMrFjs+O1fUdwQoILK1YPyEw0+FpRc/ue5t+Mz/nQUeAssfs3xT8UTDtTT2GtwxDHkilGYEyHMQsDMgjcee1iPW5wLCnU9LIvIIf/FjjeqLVR/8AjZJM5NnLhJ0IDRLken5Q2+BMFUN2wDwTiCNUx8oqd8cQTHWxEylGfbu6FPBhl/sv9/RGiqTTOk6Jcp75N964glKF7M90rCgMc/QJ1RB9osPW/sDzWF4F4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=fravix.pl; dkim=pass (2048-bit key; secure) header.d=fravix.pl header.i=@fravix.pl header.a=rsa-sha256 header.s=mail header.b=Xg/X+XnC; dkim-atps=neutral; spf=pass (client-ip=54.37.225.206; helo=mail.fravix.pl; envelope-from=karolina.grabas@fravix.pl; receiver=lists.ozlabs.org) smtp.mailfrom=fravix.pl
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=fravix.pl
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=fravix.pl header.i=@fravix.pl header.a=rsa-sha256 header.s=mail header.b=Xg/X+XnC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=fravix.pl (client-ip=54.37.225.206; helo=mail.fravix.pl; envelope-from=karolina.grabas@fravix.pl; receiver=lists.ozlabs.org)
X-Greylist: delayed 512 seconds by postgrey-1.37 at boromir; Thu, 03 Jul 2025 18:16:39 AEST
Received: from mail.fravix.pl (mail.fravix.pl [54.37.225.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXqNl5kjbz2yf3
	for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Jul 2025 18:16:39 +1000 (AEST)
Received: by mail.fravix.pl (Postfix, from userid 1002)
	id B062525CB4; Thu,  3 Jul 2025 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fravix.pl; s=mail;
	t=1751529925; bh=hOfcRWJkznhN/l+zfpnezOZxK7zE+eLHRMW/owZz45w=;
	h=Date:From:To:Subject:From;
	b=Xg/X+XnCE5hJlZv+RKP/ojf/s+W85ZNgHznWpnWpK4Vfzq2r7oEqCn2guAwL9QGxr
	 L6NIKYls0LxPAb5jFIGzvB0qrPwg2Vxcm749DNP1tPOUDfq7jlY7ujlVaDIyEkyw3D
	 bp7O5KFMyXYJ6zDVQHh8MUOsQowSNvyuXZxGV4zQuGn2JlywDuTSAx1/je092niBjt
	 iSNgfbAwuaVvdnyF14XbNnnqhZjEkYYdiHSn/FcpPGzY0igHt9PHD3gT9KhrERSALr
	 aVfGHlZgkkUfXm809eGXy4HXebL01h1LBnKD1kxd9i9iGfnpE2B34kib0SCLGnJb1D
	 eqw2TNNszo9ww==
Received: by mail.fravix.pl for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Jul 2025 08:05:03 GMT
Message-ID: <20250703064500-0.1.8s.z9il.0.0som0m0hsi@fravix.pl>
Date: Thu,  3 Jul 2025 08:05:03 GMT
From: "Karolina Grabas" <karolina.grabas@fravix.pl>
To: <linux-aspeed@lists.ozlabs.org>
Subject: Nowy faktoring
X-Mailer: mail.fravix.pl
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

czy czas oczekiwania na p=C5=82atno=C5=9Bci nie blokuje u Pa=C5=84stwa bi=
e=C5=BC=C4=85cych dzia=C5=82a=C5=84?

Oferujemy faktoring, kt=C3=B3ry pozwala od razu uwolni=C4=87 =C5=9Brodki =
z wystawionych faktur i zachowa=C4=87 p=C5=82ynno=C5=9B=C4=87 bez anga=C5=
=BCowania kredytu.=20

Je=C5=9Bli to temat warty rozmowy =E2=80=93 ch=C4=99tnie opowiem wi=C4=99=
cej.


Pozdrawiam
Karolina Grabas

