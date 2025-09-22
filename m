Return-Path: <linux-aspeed+bounces-2325-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01080CAC5AD
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 23:43:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW06Y090Dz3cYG;
	Tue, 23 Sep 2025 09:43:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758573030;
	cv=none; b=GuDLFzX5cKQml6Xb5x30rAoIZMhsjlJZjLoW7PRTmMILwGxH5Kf69Ftk64JHDMq6RBcP2T+uMf6Ktb16IGNzS75cKEMzN+tkuwN5W11MJWlp26VlNTyxdWfBrklA5ZYNXQ+pJ94J4H9jYNVdz3EqiHAvQonJjtbMquQeSOFY0drrKP8nPYPPYqDHoGuMRiZosN1Mh1mnF+q9FDHWGRncQlx7Xjj5tNvmI/E3kDNWhfI66mSZQx/7UvfAuCci5W9RGljjtRLYfhj9ijvWIhQ+kCiQOODVXOu/nUTybWadnjBaiR2zKP2aMtcPkkAb/LWHQY02jPV2Yp3lpXjI8tj3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758573030; c=relaxed/relaxed;
	bh=f21DJ6iYS1AxepjbbwpyUgIz1EeYo2MNWy5iIbDBSNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XO0kpLqEatrjwS8di9AdcWxwBu6zh0sjs59mJ1P/A487f6pPv0NpGjlTVOP2PtVK9idbUZG+ybwQ1O3AoL4/X/qYyJ7J6rp3AJPNveknLXQTqjr+NuHcrE+sA3y2lhH8CRUqurAJjSX67y6zn8y5+MJvLSRf+WEQ4DJPPqPolDOg9tUcxrB5+lFtStO1hFqqXzO3wSa+zlvY9IG61OSKqh9eOi/qvA5RXLHNR18ZVbcdRsaoSReRi6BjNEdZ1M3uScwhKdd+KMoz6Z1ukxdkfVvw97Q6aV7H4vmJIauMfgV0Qy7xelDWSCIDHtAgYwJ1z0kTEQlv0YqTWyYfZRooEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=nyo6oT3T; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=U/yyLiv+; dkim-atps=neutral; spf=pass (client-ip=103.168.172.155; helo=fhigh-a4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=nyo6oT3T;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=U/yyLiv+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.155; helo=fhigh-a4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVvr43sXfz2yr6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 06:30:28 +1000 (AEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B78311400195;
	Mon, 22 Sep 2025 16:30:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 22 Sep 2025 16:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758573024;
	 x=1758659424; bh=f21DJ6iYS1AxepjbbwpyUgIz1EeYo2MNWy5iIbDBSNA=; b=
	nyo6oT3TzFlY5I0WXnpyAEAGvwZ7yrOX381aUcW9MCrYjV1HUsv9GNg3x9EVY5/Y
	QWL6QAHCBzf4jqps7hUL3qLz08wWgu5L9PApxBmv5Nq2GjC2S9Mw32eH7y5FSsrL
	mfMy+vxc2HGCVhIXq5c7ufejrBWddxrhN7H/vmBJ6lIfF2d29hXEE4guxmCGb6O2
	tAN9UZB/6gYpk3kLx+AOh7wcP9SFQxEWxTgBKNMOYxfIg694Z2HsKPnMoL+Ll5Xv
	wA9u54MFXg7WqqinMg3l/QI9rhMTX1kA1HkQpcYjsI1CL34LwrH+rbI6Q/DcrN91
	PsPP3aIPgrWohrbWxj925w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758573024; x=
	1758659424; bh=f21DJ6iYS1AxepjbbwpyUgIz1EeYo2MNWy5iIbDBSNA=; b=U
	/yyLiv+pWD3PyJ3colP+XRK6MtW9++tb2sQ00VzQVnQg92g9ccest3ombaG+YE9Z
	Krp5L8hUTSwwYZBpJHra0KTIURfdnOoyX97uyApKmoZpR+6I9N3SkjCLej4/U4LK
	W27W/vuevB1bUNXLn79QfBKen7v8V4DZpm0g34qjTPm4Th2j7O3z714F5uVU9yol
	YAOQTQVGV2eFRnFHuR0t+gdIMGUv+R5x9d/FkA6uAN01QUeF4gXdInta6cHiDpUO
	hmWokA3rolCedc/plYPHvqBVG/la2lgP/LZNJurANuWShYf7RfoIoqu2BtqcwujY
	ZqmsIN51rVyGYb1xe6s3g==
X-ME-Sender: <xms:37HRaIwsafr6gF3kyW0TLuRr05Zet02ihsvoDiCsstmJ3xvHKBm5hQ>
    <xme:37HRaIKSwoxwHK11CbSILFjipTABJQ4lz85Fs-wSsrqBypGmoJEqed1pxua3eIG4x
    RWTyUIAPiBNQ6FvK89blT_-RMo88N3Ez91tGliBzaMVDccw0QqEklnX>
X-ME-Received: <xmr:37HRaHVIHFrvchhMAVw8xJPWG_KL1xYPiWSMNivnGnuUo4hlX_T7MeUbQC7yDEsqLf51VWu0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptfgvsggvtggt
    rgcuvehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvg
    hrnheplefhgeevleehieeuveduudfguedtieetteevhffgfffhhffhveffueegtdegkeek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsg
    gvtggtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeiivghvsegsvgifihhluggvrhgsvggvshhtrdhnvghtpd
    hrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdo
    ughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtohep
    rghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhope
    guvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilhgrsghsrdho
    rhhg
X-ME-Proxy: <xmx:37HRaLZiMcZINQDA-uN_LIPEmV_2dg0aaXPTlLUgkpr3xZ7YeQEAKA>
    <xmx:37HRaOzEz13wT_YWvqqDiFluHmxDfIwe9y7cAe2MqgagHS8kgzgsSw>
    <xmx:37HRaL0doQA-z0ua5-aE69gyuEoO6O8YFf-A-gIHr5jrgYcwcxbgVA>
    <xmx:37HRaPkNGJxoOUR2aaf1rlJRRsI-G33G6vzTzi4gAB_GkHccQ5D49Q>
    <xmx:4LHRaF988bm42vHCFUaajGuBKhBjIO4Bn-IfDrAeVWs788Ar0EZuBfyb>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 16:30:22 -0400 (EDT)
Message-ID: <354c5977-2bab-446f-9ae0-b01d678fd74f@bsdio.com>
Date: Mon, 22 Sep 2025 14:30:21 -0600
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Zev Weiss <zev@bewilderbeest.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
 <66c5bf80-a3ef-4984-82ce-6d1720b15d38@hatter.bewilderbeest.net>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <66c5bf80-a3ef-4984-82ce-6d1720b15d38@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 00:29, Zev Weiss wrote:
> Here and on most of the other i2c busses, is there a particular reason 
> we want this bus-frequency explicitly specified?  100kHz is the 
> default according to 
> Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml (and the other 
> existing aspeed-bmc-asrock-*.dts files leave it at that implicit 
> default, FWIW).

There's no particular reason - I've deleted them.

> It looks like this device only monitors temperatures?  If so, perhaps 
> temperature-sensor@29 would be a slightly more appropriate node name.

The chip can also monitor power supply voltages and fan speeds but on 
this board it's only used as a temperature sensor, so I'll change the 
node name.

> channel@1 and channel@2 block bodies look over-indented by one level 
> here.

Thanks - fixed.

> Are these correct?  On every other ASRock board I've dealt with, the 
> eth0 address is at 0x3f80 and eth1 is at 0x3f88.
>
> If so and they are really for some reason swapped on this platform, as 
> a slight nitpick I might suggest swapping the order the nodes are 
> listed in so they go in order of increasing addresses.

After installing the latest 3.06 BMC firmware from the ASRock website, 
I'm seeing:

root@altrad8ud-1l2t:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 9C:6B:00:43:0B:F7
           inet addr:10.0.0.25  Bcast:10.0.0.255 Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:457 errors:0 dropped:0 overruns:0 frame:0
           TX packets:240 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:88379 (86.3 KiB)  TX bytes:17663 (17.2 KiB)
           Interrupt:26

eth1      Link encap:Ethernet  HWaddr 9C:6B:00:43:0B:BD
           inet addr:10.0.0.11  Bcast:10.0.0.255 Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:368 errors:0 dropped:0 overruns:0 frame:0
           TX packets:26 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:88134 (86.0 KiB)  TX bytes:3507 (3.4 KiB)
           Interrupt:27

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:65536  Metric:1
           RX packets:434 errors:0 dropped:0 overruns:0 frame:0
           TX packets:434 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:34479 (33.6 KiB)  TX bytes:34479 (33.6 KiB)

usb0      Link encap:Ethernet  HWaddr 4E:F6:84:8E:63:B9
           inet addr:169.254.0.17  Bcast:169.254.255.255 Mask:255.255.0.0
           UP BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

root@altrad8ud-1l2t:~# hexdump -C /sys/bus/i2c/devices/7-0057/eeprom
...
*
00003f80  9c 6b 00 43 0b bd ff ff  9c 6b 00 43 0b f7 ff ff 
|.k.C.....k.C....|
00003f90  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
|................|
*
00003fd0  1e 90 db 9a 13 ff cb ff  4e f6 84 8e 63 b9 8e ff 
|........N...c...|
00003fe0  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff 
|................|
*
00004000


I don't know why they're swapped, but I think keeping them that way 
makes sense to avoid people's IP address changing.

> As the DTBS_CHECK lint reported and Andrew Jeffery commented on, these 
> two partitions overlapping is a bit surprising -- is that intentional?

It was intentional since I've updated the firmware update script to be 
able to program the TF-A or UEFI areas separately, or the entire code 
region (i.e. TF-A _and_ UEFI, excluding the data/configuration areas of 
the EEPROM). But I'll update the script to not depend on there being a 
'code' partition that covers both areas.


-- 

Rebecca Cran


