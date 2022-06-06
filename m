From: Corentin Labbe <clabbe.montjoie@gmail.com>
Date: Mon, 6 Jun 2022 10:22:41 +0200
Subject: [PATCH 1/5] crypto: aspeed: Add HACE hash driver
In-Reply-To: <HK0PR06MB320263939B2E388481DE2A0A80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-2-neal_liu@aspeedtech.com>
 <YpcYLiJfC6tgP2Nj@Red>
 <HK0PR06MB320263939B2E388481DE2A0A80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <Yp25UVBCNHzeiQOn@Red>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le Wed, Jun 01, 2022 at 08:38:51AM +0000, Neal Liu a ?crit :
> > Le Wed, Jun 01, 2022 at 01:42:00PM +0800, Neal Liu a ?crit :
> > > Hash and Crypto Engine (HACE) is designed to accelerate the throughput
> > > of hash data digest, encryption, and decryption.
> > >
> > > Basically, HACE can be divided into two independently engines
> > > - Hash Engine and Crypto Engine. This patch aims to add HACE hash
> > > engine driver for hash accelerator.
> > >
> > > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > > Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> > 
> > Hello
> > 
> > Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y (you should
> > said it in cover letter).
> > There are several easy style fixes to do (please run checkpatch --strict) Did you
> > test your driver with both little and big endian mode ?
> > 
> 
> Yes, I also test it with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y. I'll describe it in cover letter as you suggested.
> And the style problem would be fixed, thanks for your suggestion.
> 
> How to test it with both little and big endian mode? It would be appreciated if you give me some clue.
> 

Hello

Sorry for the delayed answer.

You should try compiling and booting with CONFIG_CPU_BIG_ENDIAN=y

> > Also please see my comment below.
> > 
> > [...]
> > > +/* Initialization Vectors for SHA-family */ static const u32
> > > +sha1_iv[8] = {
> > > +	0x01234567UL, 0x89abcdefUL, 0xfedcba98UL, 0x76543210UL,
> > > +	0xf0e1d2c3UL, 0, 0, 0
> > > +};
> > > +
> > > +static const u32 sha224_iv[8] = {
> > > +	0xd89e05c1UL, 0x07d57c36UL, 0x17dd7030UL, 0x39590ef7UL,
> > > +	0x310bc0ffUL, 0x11155868UL, 0xa78ff964UL, 0xa44ffabeUL };
> > > +
> > > +static const u32 sha256_iv[8] = {
> > > +	0x67e6096aUL, 0x85ae67bbUL, 0x72f36e3cUL, 0x3af54fa5UL,
> > > +	0x7f520e51UL, 0x8c68059bUL, 0xabd9831fUL, 0x19cde05bUL };
> > > +
> > > +static const u32 sha384_iv[16] = {
> > > +	0x5d9dbbcbUL, 0xd89e05c1UL, 0x2a299a62UL, 0x07d57c36UL,
> > > +	0x5a015991UL, 0x17dd7030UL, 0xd8ec2f15UL, 0x39590ef7UL,
> > > +	0x67263367UL, 0x310bc0ffUL, 0x874ab48eUL, 0x11155868UL,
> > > +	0x0d2e0cdbUL, 0xa78ff964UL, 0x1d48b547UL, 0xa44ffabeUL };
> > > +
> > > +static const u32 sha512_iv[16] = {
> > > +	0x67e6096aUL, 0x08c9bcf3UL, 0x85ae67bbUL, 0x3ba7ca84UL,
> > > +	0x72f36e3cUL, 0x2bf894feUL, 0x3af54fa5UL, 0xf1361d5fUL,
> > > +	0x7f520e51UL, 0xd182e6adUL, 0x8c68059bUL, 0x1f6c3e2bUL,
> > > +	0xabd9831fUL, 0x6bbd41fbUL, 0x19cde05bUL, 0x79217e13UL };
> > > +
> > > +static const u32 sha512_224_iv[16] = {
> > > +	0xC8373D8CUL, 0xA24D5419UL, 0x6699E173UL, 0xD6D4DC89UL,
> > > +	0xAEB7FA1DUL, 0x829CFF32UL, 0x14D59D67UL, 0xCF9F2F58UL,
> > > +	0x692B6D0FUL, 0xA84DD47BUL, 0x736FE377UL, 0x4289C404UL,
> > > +	0xA8859D3FUL, 0xC8361D6AUL, 0xADE61211UL, 0xA192D691UL };
> > > +
> > > +static const u32 sha512_256_iv[16] = {
> > > +	0x94213122UL, 0x2CF72BFCUL, 0xA35F559FUL, 0xC2644CC8UL,
> > > +	0x6BB89323UL, 0x51B1536FUL, 0x19773896UL, 0xBDEA4059UL,
> > > +	0xE23E2896UL, 0xE3FF8EA8UL, 0x251E5EBEUL, 0x92398653UL,
> > > +	0xFC99012BUL, 0xAAB8852CUL, 0xDC2DB70EUL, 0xA22CC581UL };
> > 
> > Thoses IV already exists as define in linux headers (SHA1_H0 for example) But I
> > am puzzled on why you invert them.
> > 
> 
> This is Aspeed hardware limitation.

The limitation is that hardware does not know theses IV ?
Having them inverted seems to proof that you have some endianness issue.

> > 
> > Why didnt you use the crypto_engine API instead of rewriting it.
> 
> Any common crypto_engine API can be used? I did not find any, Maybe I miss something.
> It would be appreciated if you give me some clue.
> 

Please check crypto/crypto_engine.c.
You could take crypto/omap and allwinner/sun8i-ce as example of usage.

Regards
