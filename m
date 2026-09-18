Return-Path: <linux-aspeed+bounces-5028-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCEC982CC
	for <linux-aspeed@archiver.kernel.org>; Sun, 20 Sep 2026 07:46:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hndjM5tsZz2y8c;
	Sun, 20 Sep 2026 17:46:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789751143;
	cv=none; b=U8DeG2mgktKJMx9ubsXja8UmeLvRPmEZCXGSHR3XdK66SHe6i2e10rXjHt0erbN3Plio/o/rquKbA09DCQW4irJlZWDivsmQfTNoQto7a6P8Pf8pKTk3x//Zr3Jns8TYef67t5RB+kcsJ4ke5QMhX0c9wlObflTmXy4wLig67ZlXLeU5aAaDSTt5DAsSJeC8MlmxFceHsSMM7fEjFNt5DSf+nX987pWtatNkWxt0w7vkOB1BDe3vj733aydcA4TKRk6q8JmMjLu7mkmTA+nNGniHmcgS2PCOaF1Au9KaoQ8KQrfBbR9KB/EjdJ0tEoyN2/w/XgSeUqDQvI8/32sK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789751143; c=relaxed/relaxed;
	bh=QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dSWePTt4TCVVx5Syijvwxtp5nbbknDceMzat7juT7lnZHXOrJeSNK/lTkJHJAMRBIbsQxMHLg30Zv4QVX3LU5KBpklk//w+HmohRAKJNwg+E6ZKmBa87yup4lQKvT6q9A36T/O73dCyy+oQxf9cAQhBaF9DQuDU3SIJ/EzwNZs32K8QxkbpLq4K4uDbOIxULouTTslP8xqhIiEk0tpoyYaXtSEqPmXhsTUpBzs9y/wdje3Q655CO12o/IBQhSWI3D0z5M6VRYsO62qh1S+6vPcuTdjtSj4Zotn2Xc2SRlETovkLMztTrJqc6rVWa37XAazgkdSMLEZL1xesyAyDDmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WMMuEWXH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aaGLV6Vv; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WMMuEWXH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aaGLV6Vv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmfCC01M1z2xYg
	for <linux-aspeed@lists.ozlabs.org>; Sat, 19 Sep 2026 03:05:42 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IGoFcm1666318
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 17:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=; b=WMMuEWXHWJBv/taD
	f9QZUlE46GdUzuTjYYf/C3doWA0kR+Y5MgruXgzoDKrnaUUWblDlcnoq62X0pGZb
	/qbl9/Nh08g2JIywKdvQgqoIFODG95dmBYMwKhKE8pfH/9GV1s9uiIZ/ny0o1Ct9
	AxCx/8lN1sOSKnfJuvaS1JUg9GiNW/atd+A2FpRM9LBALe3ZTIKYfBJ7XUzkVsAm
	/0Sfv53h7nA91Txh3LNTG0XJ02vyxwLdjN4jnrj+2hSOYEPJdtabTGR3PdaWxCxi
	qwYwhp2WIMT4a5wkgjtCyWIgf1y9m/+GKe3lh+g7l4PT8AQ6cRmW8HyvIVAcaiX9
	oOwVlA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grxp2txtv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 17:05:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6fed0652bso11313385ad.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Sep 2026 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789751138; x=1790355938; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=;
        b=aaGLV6VvR24tY0tAIrMFUvNY0sl0UUmbDGRYRF/bHRcwNNNpMAAV/zrJhpC4KhX0/0
         HvBmj6lbNtib6yEXf7qkcHOkqHSFp785a9b3Sm0yPeM5JJpEsb7Nf2OqdnXTe/rjWt+I
         bsjvQJ9l+HTXEQISo71BK6dWaKyIbdC12GE8P5jluvlcP4IqlqlMRgDla4rlHZ6FRSk3
         N1p5YilvfJ4TXnV+e2cvg1NYE0gGMhG9tNpWIm7LBrrzZUg7y3MEgxip+Yq1dros0J1o
         OITxCqmHu+LqBhx2ohfW8pWFJRBOqHGmL9js+HBkra01S9Lsu3DeylxraT5jWAW3DoRU
         5lBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789751138; x=1790355938;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMjXKTddFP/KRl7r6fg9f8x2YOcB9udmZHxfTy35BWA=;
        b=tZvp3rEXxz8RT9nyeFX0ocrFk7VLnC3agEVy4UjFOpJ18Kv0z951ts+rWEaphHRBQU
         WREvJkgBEc9bBaj+j3jfA6Q0/ndzzR9YLFZikJmV8JczH7gz8A6Z265gHzTDNcicJuhm
         X0i9POpUmkCrhbDxe3/bABq8U+/fZBlt8gt+PXN0pw/bHnDZGK1pDe+ith85ggW8F4Dw
         ianuK/lcxua3RsuHpSuvfrcU4LmV5Ypl8LQpxvpPNn9oF51bCcoLiyWpK6Za9/cplSim
         zyqvjpO0l3Lx76LAQNV7lWVosNigHaN5WGzHqUVM3W+DLc7h7ISwHtc4N59wa1wqphE5
         34OQ==
X-Forwarded-Encrypted: i=1; AKwUvBxh8UAsz5INYeWNZTFxUBlKXOc369wd0qZBwV/gzGia0aIzFmzczERYmbdnhpPu4639mmsHp9H1hhs2Y4c=@lists.ozlabs.org
X-Gm-Message-State: AFuF++m3+1Eb1oqT82a9If0NCFSyanbFOMM4l6wyUp0YgN2FaCSrkdP3
	wAWXxVYyoDt/92rYIqWjntnB5yqHxwGEoICHQ+auubhFvLCA2zokQMZDw2fdU+vELAnPzfVRGs5
	4fhm49Fb74B4FQBoN75uikL/JM8yKaR4BrjyIJupDwoZvLdPyu2dJxBzL04TxS5WF8b42
X-Gm-Gg: AYBFou0lQW1s2fjD1LhyrS4TpTOy5N0OId4mUoUXfPuZOHuG4j/Wgm65NSIp2F/6B3A
	5CKdOTGt9gV0PNziZSnDV0VNgxqwKWK/apZIHm04PlCfPB4AI9x62clp2m7Tl9QM5OmMPz5bP1z
	hkz+uUNN5lSqP6iWCzuve2rP24iL/W581sKrY6FMh1MqyauHNy8VEKFL5/DbnYNmswtRM0AG9Hn
	mVdent6cWZNhSxYEyieWQMqxxAN9IkdLtlAStje9/8wfcRDsgg8cE7x/c4/gdda9yfzbHdUxDTc
	fjyV4yBwI18/7Bn0RbWnxULKbgscSfq6s81Qhq3cr2XHg7bRibxvcPjkp+lPo3BVlMUT4rhc1CQ
	Y7GITXA==
X-Received: by 2002:a17:902:fc50:b0:2dd:c053:e0f6 with SMTP id d9443c01a7336-2ddc053e13emr7876645ad.37.1789751138500;
        Fri, 18 Sep 2026 10:05:38 -0700 (PDT)
X-Received: by 2002:a17:902:fc50:b0:2dd:c053:e0f6 with SMTP id d9443c01a7336-2ddc053e13emr7876085ad.37.1789751137947;
        Fri, 18 Sep 2026 10:05:37 -0700 (PDT)
Received: from localhost ([143.246.51.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75ae73csm11519845ad.57.2026.09.18.10.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:05:37 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 01:05:13 +0800
Message-Id: <DLILTJ12IX36.15ABZZEUMTL59@oss.qualcomm.com>
Cc: "Ze Huang" <ze.huang@oss.qualcomm.com>,
        "Alexey Brodkin"
 <abrodkin@synopsys.com>,
        "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>,
        "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
        "Joel Stanley" <joel@jms.id.au>,
        "Andrew
 Jeffery" <andrew@codeconstruct.com.au>,
        "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team"
 <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Linus
 Walleij" <linusw@kernel.org>,
        "Hans de Goede" <hansg@kernel.org>,
        "Alex
 Lanzano" <lanzano.alex@gmail.com>,
        "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>,
        "Philipp Zabel"
 <p.zabel@pengutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>,
        "Marian Cichy" <m.cichy@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v3 2/2] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Maxime Ripard" <mripard@kernel.org>,
        "Thomas Zimmermann"
 <tzimmermann@suse.de>
X-Mailer: aerc 0.22.0.r10.g73f20125
References: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com> <20260727-drm-simple-kms-removal-v3-2-de36e534f7a1@oss.qualcomm.com> <8e4c84be-5c89-4d84-adda-aad4c7de0c8a@suse.de> <aqpJKSSKunElnQ3o@houat>
In-Reply-To: <aqpJKSSKunElnQ3o@houat>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfX9qCNtGCdVpEK
 BT8fUhg/TZA6kQBUA3SUjSgJ9nUGWIxsyfdW4G6kl+Y0GmSozH8dmThSl8VjOx5ItZYdJbyckKi
 g7YbJEwHoLndYGGhQtRBegnO65U3hsg=
X-Proofpoint-GUID: mtZ6hsUbfZi9lE_uX4NxyEt8J55TzrLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI0NSBTYWx0ZWRfX23VCjjgumqKT
 1IuVco9Xn380neasbKS9iElFhZVvOPSD6SMk4NbBAB04vg2LL6r2jxKmL2jQ69NZHI86cEHKxIq
 +a67gh67b4J2r03jvG4EbOnkFBI6K/IO85b7jqwKGUqO312JY0nukhTWKKdelwOVEugonLW6+It
 Dmj3vQ9QpjF7/yKZBxv3+e1VuVMot3L0DNpTzUNPfVOF8RFG3XIy3wccv0MJq701uIc92Bltjhp
 2FP11kdU2cTfNE5fEnBKl7EqLrTt2DM1a9vogI3pEkXjY7Yu5zWjbh5/hK2JRHKa8vQyXzQIOfU
 dcwGOVypLf3H9M0jUDcbSEBWuR1nDjBW9a+w7xkwSka1ZSKqe+l+7kAlJAKZsrt52NTvwPsSCgy
 L83kZdo3eOclOLdlIJCzEgRZWHlHbwiJHV+SQONOBjJ1a1ivVcfCiV4+/17y7LNlGofVjNgL34Y
 Axslgp3EE5c5nv2QNqw==
X-Proofpoint-ORIG-GUID: mtZ6hsUbfZi9lE_uX4NxyEt8J55TzrLf
X-Authority-Analysis: v=2.4 cv=cNF1IVeN c=1 sm=1 tr=0 ts=6aad6f63 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=LNnhWNgewsfctp/cwirQdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=IqZAcGRvIuv5jEvzszIA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180245

On Wed Sep 16, 2026 at 3:46 PM CST, Maxime Ripard wrote:
> On Wed, Sep 16, 2026 at 08:50:21AM +0200, Thomas Zimmermann wrote:
>> > +static const struct drm_plane_funcs imx_lcdc_plane_funcs =3D {
>> > +	.update_plane		=3D drm_atomic_helper_update_plane,
>> > +	.disable_plane		=3D drm_atomic_helper_disable_plane,
>> > +	.destroy		=3D drm_plane_cleanup,
>> > +	.reset			=3D drm_atomic_helper_plane_reset,
>
> Also, this needs to be drm_atomic_helper_plane_create_state
>
>> > +static const struct drm_crtc_funcs imx_lcdc_crtc_funcs =3D {
>> > +	.reset			=3D drm_atomic_helper_crtc_reset,
>
>  and drm_atomic_helper_crtc_create_state
>
> Maxime

Thanks for the reminder. Will do.

Ze

